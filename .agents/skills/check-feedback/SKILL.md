---
name: check-feedback
description: Pull the latest PR/MR feedback for a Jujutsu revset and report what's new, unresolved, and actionable — adapting to whether it's your own PR (triage feedback to address) or someone else's you're re-reviewing (what changed since your last review, plus an approval verdict)
---

# check-feedback - Pull and review PR/MR feedback

Fetch the latest feedback on a pull/merge request and report it inline. Report-only: do not draft replies, do not edit code, do not resolve threads. The user decides what to do next.

This is distinct from `/review`, which produces a fresh staff-engineering review of the code. `/check-feedback` summarizes what has *already* happened on the PR and where things stand.

## Two modes — detect which one you're in

There is a meaningful difference between the two reasons to run this skill, and the report should reflect it:

- **Author mode — it's *your* PR.** Others have left feedback and you want to know what's new, unresolved, and actionable *for you to address*. **Do not give an approve/reject verdict** — you can't approve your own PR, and it's not the question. The question is "what do I still owe here?"
- **Reviewer mode — it's *someone else's* PR you're re-checking.** You (or the user) reviewed it before and want to know **what changed since your last review**, whether your prior comments were addressed, and — this time — **whether to approve now**.

Detect the mode automatically in step 4 by comparing the authenticated user to the PR author. State which mode you're in at the top of the report so the user can correct you if the detection is wrong (e.g. team PR where the "author" of record isn't the person who asked).

## Usage

```text
/check-feedback [revset|number]
```

Examples:
- `/check-feedback` → infer PR/MR from the bookmark on `@` (or the nearest ancestor with a tracked bookmark)
- `/check-feedback @-` → use the bookmark on the parent change
- `/check-feedback nwr` → use the bookmark on change `nwr`
- `/check-feedback 1234` → use PR/MR number `1234` directly

## Workflow

1. **Detect forge**
   ```bash
   jj git remote list
   ```
   - Fall back to `git remote get-url origin` only if `jj` is unavailable.
   - GitHub host → use `gh`.
   - GitLab host → use `glab`.
   - Verify auth before fetching:
     ```bash
     gh auth status   # or: glab auth status
     ```

2. **Sync local state with origin**

   Your working copy may be stale: the author can push new commits after you last pulled, leaving `@`'s parent on a commit that no longer matches the PR head. The tell is inline threads reported as *outdated* against an anchor you reviewed. Refresh before reading feedback so the cross-check in step 7 runs against the code reviewers actually see.
   ```bash
   jj git fetch
   ```
   - This updates remote-tracking bookmarks (e.g. `<bookmark>@origin`) without touching your working copy.
   - If `@` (or its nearest bookmarked ancestor) is now behind `<bookmark>@origin`, move onto the fetched head:
     ```bash
     jj new <bookmark>@origin
     ```
   - Only move the working copy when it's empty / has no in-progress edits to preserve. If `@` carries uncommitted work, leave it put and instead inspect the PR head by revision (`<bookmark>@origin`) in step 7 rather than relocating.
   - Git fallback (only if `jj` is unavailable): `git fetch origin`, and `git switch`/`git checkout` only when the tree is clean.

3. **Resolve the PR/MR number**
   - If the user passed a bare number, use it.
   - Otherwise resolve from the revset:
     ```bash
     # Find the bookmark on the target rev (default @)
     jj log -r '<rev>' --no-graph -T 'bookmarks ++ "\n"'
     ```
     - If no bookmark on the rev, walk back to the nearest ancestor with one:
       ```bash
       jj log -r '::<rev> & bookmarks()' --no-graph -T 'change_id.short() ++ " " ++ bookmarks ++ "\n"'
       ```
     - With a bookmark name, look up the PR/MR:
       ```bash
       gh pr list --head <bookmark> --state all --json number,url,state,title
       # or
       glab mr list --source-branch <bookmark> --all
       ```
   - If nothing matches, report that no PR/MR exists for the revset and stop. Don't guess.

4. **Determine your role — author or reviewer**

   Compare the authenticated user to the PR author:
   ```bash
   gh api user --jq .login                              # your login
   gh pr view <number> --json author --jq .author.login # PR author
   # GitLab: glab api user --jq .username ; glab mr view <iid> --json author
   ```
   - **You are the author** → **author mode.** Skip the approval verdict (step 9). Frame the report around what *you* need to address and what you can now resolve.
   - **Someone else is the author** → **reviewer mode.** Find the anchor for "since last review": your most recent review on this PR and the commit it was made against.
     ```bash
     gh api graphql -f query='{ repository(owner:"OWNER", name:"REPO") {
       pullRequest(number: NUM) { reviews(last: 30) { nodes {
         author { login } state submittedAt commit { oid } } } } } }'
     ```
     - Pick the latest review whose `author.login` is you; its `commit.oid` is your last-reviewed anchor.
     - If you have **no prior review**, this is a first review — treat every commit and thread as new, skip the "since last review" diff, and still give a verdict.
   - State the detected mode explicitly in the report header so the user can override it.

5. **Pull the feedback**

   **GitHub (`gh`)**
   ```bash
   # PR metadata + top-level conversation + reviews + merge-gating decision
   gh pr view <number> --json number,url,title,state,isDraft,author,headRefName,baseRefName,updatedAt,reviewDecision,reviews,comments

   # Review threads WITH resolution state — via GraphQL (the `reviewThreads`
   # --json field is unsupported on some gh versions; see Notes).
   gh api graphql -f query='{ repository(owner:"OWNER", name:"REPO") {
     pullRequest(number: NUM) { reviewThreads(first: 50) { nodes {
       isResolved isOutdated path line
       comments(first: 10) { nodes { author { login } body createdAt } } } } } } }'

   # Inline code-review comments with file/line anchors and in_reply_to chains
   gh api repos/{owner}/{repo}/pulls/<number>/comments --paginate

   # Check runs / status (often referenced in feedback)
   gh pr checks <number>
   ```

   **GitLab (`glab`)**
   ```bash
   glab mr view <iid> --comments
   # Inline notes (per-line discussions) via the API if needed:
   glab api projects/:fullpath/merge_requests/<iid>/discussions
   ```

6. **Classify each thread**

   For every review thread / discussion:
   - **Unresolved + actionable** — reviewer asked for a change or raised a concern that hasn't been addressed.
   - **Unresolved + question** — reviewer asked for clarification; no code change implied yet.
   - **Unresolved + nit/optional** — explicitly marked nit, suggestion, or "non-blocking".
   - **Resolved** — already marked resolved; skip in the main report (mention only if relevant context).
   - **Addressed in a later commit** — thread is open but the diff already reflects the ask. Flag this so the user can resolve the thread.

   For each thread, capture:
   - file:line anchor (for inline comments)
   - reviewer handle
   - the ask, in one sentence
   - the most recent reply (if any) and who replied
   - timestamp of the latest activity

   **Mode-specific slicing:**
   - **Author mode** — the threads that matter are the ones started *by other people* that you haven't addressed. Your own comments are context, not action items.
   - **Reviewer mode** — split threads by *who* opened them: **your** prior comments (is each now addressed by a later commit? that's the point of re-checking) vs. **other reviewers'** threads (context for your verdict). Also flag threads opened since your last-review timestamp from step 4.

7. **Cross-check against the current diff**
   - For unresolved threads tied to a file/line, check whether the current code at that location still matches what the reviewer was looking at. Inspect the fetched PR head, not a possibly-stale local rev:
     ```bash
     jj show <bookmark>@origin -- <path>
     ```
   - If the code has changed since the comment, note it as "possibly addressed — confirm" rather than "outstanding". Don't claim a thread is fixed unless the diff clearly addresses the specific ask.
   - **Reviewer mode — show what changed since your last review.** Diff the PR head against your last-reviewed anchor commit from step 4 so you review the delta, not the whole PR again:
     ```bash
     jj diff --from <last-reviewed-oid> --to <bookmark>@origin
     # or, if the commits aren't local: gh api repos/{owner}/{repo}/compare/<oid>...<head-oid>
     ```
     Use this delta to judge whether your prior comments were addressed and whether the new changes introduce anything worth raising.

8. **Note overall review state**
   - Approvals, change requests, dismissed reviews — surface the latest state per reviewer.
   - Failing required checks that reviewers have referenced.
   - Whether the PR/MR is in draft.

9. **Decide whether approval is warranted — REVIEWER MODE ONLY**

   > Skip this entire step in **author mode** — it's your own PR, so there's no approve/reject decision for you to make. Jump to the author-mode report in step 10.

   After classifying, state an explicit verdict: **would you approve this PR/MR right now?** The user wants a recommendation, not just a thread dump. Pick one:
   - **Approve warranted** — no unresolved blocking threads, required checks green, and any residual risk is operational/deferred rather than a merge blocker.
   - **Approve with follow-up** — mergeable now, but name the loose ends to track (e.g. a deferred fix in another PR/repo) so they aren't lost.
   - **Not yet** — name the specific blockers: outstanding change-requests, failing required checks, unanswered questions, or a thread whose ask the diff doesn't cover.

   Ground the verdict in evidence you can cite: which checks are green, which threads are resolved/addressed, what the cross-check in step 7 showed. Anchor it to the **delta since your last review** — if you already approved-in-spirit last time, the verdict is really "do the new changes and the addressed/unaddressed threads change that?" Separate *merge* from *deploy* when the PR gates them differently — a cutover can be safe to merge while a prod deploy stays gated.

   Look for a **`REVIEW.md`** at the root of the project this skill is running in (repo root / working directory). If present, treat it as the project's authoritative reviewer checklist: check the outstanding threads and the current diff against its criteria, and if the PR trips a checklist item that no reviewer has raised yet, surface it (citing the relevant `REVIEW.md` section) so the verdict reflects the project's own bar, not just existing feedback.

   Caveats to surface, not bury:
   - Your verdict is advice; the gating approval is a human's. Note `reviewDecision`, and whether the PR author can self-approve (they can't — so if they're the only reviewer, a second human is still required to unblock).
   - If the verdict rests on author/CI claims you didn't verify yourself (e.g. you didn't re-run a generator or reproduce a test), say so — name the signal it leans on.

   **Recommending is in scope; approving is not.** Never submit an APPROVE review or merge — report the verdict and let the user act.

10. **Report**

    Lead with the mode you detected in step 4, then branch:

    **Common header (both modes):** PR/MR number, URL, title, state (open/draft/merged), base ← head, last updated, and **detected mode** (your PR / reviewing <author>'s PR).

    **Author mode (your PR) — you owe the next move:**
    - **What you need to address** (unresolved + actionable), grouped by file, each citing reviewer and file:line. This is the headline — it's what's blocking *you*.
    - **Open questions** reviewers asked — you owe a reply, not necessarily a code change.
    - **You can resolve these** — threads where a later commit already covers the ask (from step 7); confirm and mark resolved.
    - **Nits / optional** — short list, one line each.
    - **Review state** — who's approved / requested changes / not yet reviewed, and any failing required checks.
    - **No approval verdict.** It's your PR.

    **Reviewer mode (their PR) — you owe a decision:**
    - **Approval verdict** (from step 9): approve-warranted / approve-with-follow-up / not-yet, in one line with the one-clause reason and the gating caveat. Lead with this — it's the question you're re-checking to answer.
    - **What changed since your last review** — the delta from step 7, in a few bullets. If nothing changed, say so.
    - **Your prior comments** — for each, addressed / partially / not yet, citing the commit or file:line that resolves it.
    - **Other outstanding threads** (unresolved + actionable) that bear on the verdict, grouped by file.
    - **Open questions & nits** — short.
    - **Review state** — approvals/change-requests, failing checks.

    If there's nothing actionable (author mode) or nothing changed and nothing outstanding (reviewer mode), say so explicitly. Don't pad.

## Notes

- **Report only.** In reviewer mode, *recommending* whether to approve (step 9) is in scope; *acting* is not — do not submit an APPROVE/request-changes review, merge, post replies, resolve threads, push commits, or edit code. In author mode there's no verdict at all. If the user wants to act, point them at `/simplify` (apply fixes), `/post-feedback` (post review comments), or have them reply/approve/resolve directly.
- **Mode detection is a default, not a lock.** It's derived from PR authorship (step 4). If the user's framing contradicts it (e.g. "check what's left on my PR" when they're technically a co-author, or "re-review Dana's PR" on a PR of record they authored), follow the user's framing and note the mismatch.
- Cite **Jujutsu change IDs** when referring to local changes, and **PR/MR comment URLs or file:line anchors** when referring to feedback — so the user can click straight to either side.
- Resolution state on GitHub lives on `reviewThreads[].isResolved`; the older `comments` endpoint doesn't carry it. Use `gh pr view --json reviewThreads` as the source of truth for resolved-vs-not — **but some `gh` versions reject `reviewThreads` as an unknown `--json` field.** When that happens, drop it from the `gh pr view` call and fetch threads via GraphQL instead:
  ```bash
  gh api graphql -f query='{ repository(owner:"OWNER", name:"REPO") {
    pullRequest(number: NUM) { reviewThreads(first: 50) { nodes {
      isResolved isOutdated path line
      comments(first: 10) { nodes { author { login } body createdAt } } } } } } }'
  ```
- `reviewDecision` (`gh pr view --json reviewDecision`) gives the merge-gating state (`APPROVED` / `CHANGES_REQUESTED` / `REVIEW_REQUIRED`) in one field — use it for the step-9 verdict's gating caveat.
- Pagination matters on busy PRs — use `--paginate` on `gh api` calls.
- Git is a fallback only if `jj` is unavailable in the repo.
