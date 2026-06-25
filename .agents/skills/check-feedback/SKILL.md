---
name: check-feedback
description: Pull the latest PR/MR feedback for a Jujutsu revset and report what's new, unresolved, and actionable
---

# check-feedback - Pull and review PR/MR feedback

Fetch the latest feedback on a pull/merge request and report it inline. Report-only: do not draft replies, do not edit code, do not resolve threads. The user decides what to do next.

This is distinct from `/review`, which produces a fresh staff-engineering review of the code. `/check-feedback` summarizes what *other reviewers* have already said and where things stand.

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
   git remote get-url origin
   ```
   - GitHub host → use `gh`.
   - GitLab host → use `glab`.
   - Verify auth before fetching:
     ```bash
     gh auth status   # or: glab auth status
     ```

2. **Sync local state with origin**

   Your working copy may be stale: the author can push new commits after you last pulled, leaving `@`'s parent on a commit that no longer matches the PR head. The tell is inline threads reported as *outdated* against an anchor you reviewed. Refresh before reading feedback so the cross-check in step 6 runs against the code reviewers actually see.
   ```bash
   jj git fetch
   ```
   - This updates remote-tracking bookmarks (e.g. `<bookmark>@origin`) without touching your working copy.
   - If `@` (or its nearest bookmarked ancestor) is now behind `<bookmark>@origin`, move onto the fetched head:
     ```bash
     jj new <bookmark>@origin
     ```
   - Only move the working copy when it's empty / has no in-progress edits to preserve. If `@` carries uncommitted work, leave it put and instead inspect the PR head by revision (`<bookmark>@origin`) in step 6 rather than relocating.
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

4. **Pull the feedback**

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

5. **Classify each thread**

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

6. **Cross-check against the current diff**
   - For unresolved threads tied to a file/line, check whether the current code at that location still matches what the reviewer was looking at. Inspect the fetched PR head, not a possibly-stale local rev:
     ```bash
     jj show <bookmark>@origin -- <path>
     ```
   - If the code has changed since the comment, note it as "possibly addressed — confirm with reviewer" rather than "outstanding".
   - Don't claim a thread is fixed unless the diff clearly addresses the specific ask.

7. **Note overall review state**
   - Approvals, change requests, dismissed reviews — surface the latest state per reviewer.
   - Failing required checks that reviewers have referenced.
   - Whether the PR/MR is in draft.

8. **Decide whether approval is warranted**

   After classifying, state an explicit verdict: **would you approve this PR/MR right now?** The user wants a recommendation, not just a thread dump. Pick one:
   - **Approve warranted** — no unresolved blocking threads, required checks green, and any residual risk is operational/deferred rather than a merge blocker.
   - **Approve with follow-up** — mergeable now, but name the loose ends to track (e.g. a deferred fix in another PR/repo) so they aren't lost.
   - **Not yet** — name the specific blockers: outstanding change-requests, failing required checks, unanswered questions, or a thread whose ask the diff doesn't cover.

   Ground the verdict in evidence you can cite: which checks are green, which threads are resolved/addressed, what the cross-check in step 6 showed. Separate *merge* from *deploy* when the PR gates them differently — a cutover can be safe to merge while a prod deploy stays gated.

   Caveats to surface, not bury:
   - Your verdict is advice; the gating approval is a human's. Note `reviewDecision`, and whether the PR author can self-approve (they can't — so if they're the only reviewer, a second human is still required to unblock).
   - If the verdict rests on author/CI claims you didn't verify yourself (e.g. you didn't re-run a generator or reproduce a test), say so — name the signal it leans on.

   **Recommending is in scope; approving is not.** Never submit an APPROVE review or merge — report the verdict and let the user act.

9. **Report**

   Output structure:
   - **Header**: PR/MR number, URL, title, state (open/draft/merged), base ← head, last updated.
   - **Approval verdict** (from step 8): approve-warranted / approve-with-follow-up / not-yet, in one line with the one-clause reason and the gating caveat. Lead with this — it's the question the user most often actually has.
   - **Top-line status**: reviewer approvals/change-requests, failing checks worth noting.
   - **Action items** (unresolved + actionable), grouped by file, each citing reviewer and file:line.
   - **Open questions** (unresolved + question) — the author owes a reply, not necessarily a code change.
   - **Nits / optional** — short list, one line each.
   - **Possibly addressed** — threads where the diff seems to cover the ask; user should confirm and resolve.
   - **Resolved/closed since last check** — only if the user asked or it's load-bearing context.

   If there's nothing actionable, say so explicitly. Don't pad.

## Notes

- **Report only.** Recommending whether to approve (step 8) is in scope; *acting* is not — do not submit an APPROVE/request-changes review, merge, post replies, resolve threads, push commits, or edit code. If the user wants to act, point them at `/simplify` (apply fixes) or have them reply/approve directly.
- Cite **Jujutsu change IDs** when referring to local changes, and **PR/MR comment URLs or file:line anchors** when referring to feedback — so the user can click straight to either side.
- Resolution state on GitHub lives on `reviewThreads[].isResolved`; the older `comments` endpoint doesn't carry it. Use `gh pr view --json reviewThreads` as the source of truth for resolved-vs-not — **but some `gh` versions reject `reviewThreads` as an unknown `--json` field.** When that happens, drop it from the `gh pr view` call and fetch threads via GraphQL instead:
  ```bash
  gh api graphql -f query='{ repository(owner:"OWNER", name:"REPO") {
    pullRequest(number: NUM) { reviewThreads(first: 50) { nodes {
      isResolved isOutdated path line
      comments(first: 10) { nodes { author { login } body createdAt } } } } } } }'
  ```
- `reviewDecision` (`gh pr view --json reviewDecision`) gives the merge-gating state (`APPROVED` / `CHANGES_REQUESTED` / `REVIEW_REQUIRED`) in one field — use it for the step-8 verdict's gating caveat.
- Pagination matters on busy PRs — use `--paginate` on `gh api` calls.
- Git is a fallback only if `jj` is unavailable in the repo.
