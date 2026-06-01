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

2. **Resolve the PR/MR number**
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

3. **Pull the feedback**

   **GitHub (`gh`)**
   ```bash
   # PR metadata + top-level conversation + review threads (with resolution state) + reviews
   gh pr view <number> --json number,url,title,state,isDraft,author,headRefName,baseRefName,updatedAt,reviews,reviewThreads,comments

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

4. **Classify each thread**

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

5. **Cross-check against the current diff**
   - For unresolved threads tied to a file/line, check whether the current code at that location still matches what the reviewer was looking at:
     ```bash
     jj show <rev-with-bookmark> -- <path>
     ```
   - If the code has changed since the comment, note it as "possibly addressed — confirm with reviewer" rather than "outstanding".
   - Don't claim a thread is fixed unless the diff clearly addresses the specific ask.

6. **Note overall review state**
   - Approvals, change requests, dismissed reviews — surface the latest state per reviewer.
   - Failing required checks that reviewers have referenced.
   - Whether the PR/MR is in draft.

7. **Report**

   Output structure:
   - **Header**: PR/MR number, URL, title, state (open/draft/merged), base ← head, last updated.
   - **Top-line status**: reviewer approvals/change-requests, failing checks worth noting.
   - **Action items** (unresolved + actionable), grouped by file, each citing reviewer and file:line.
   - **Open questions** (unresolved + question) — the author owes a reply, not necessarily a code change.
   - **Nits / optional** — short list, one line each.
   - **Possibly addressed** — threads where the diff seems to cover the ask; user should confirm and resolve.
   - **Resolved/closed since last check** — only if the user asked or it's load-bearing context.

   If there's nothing actionable, say so explicitly. Don't pad.

## Notes

- **Report only.** Do not post replies, resolve threads, push commits, or edit code. If the user wants to act, point them at `/simplify` (apply fixes) or have them reply directly.
- Cite **Jujutsu change IDs** when referring to local changes, and **PR/MR comment URLs or file:line anchors** when referring to feedback — so the user can click straight to either side.
- Resolution state on GitHub lives on `reviewThreads[].isResolved`; the older `comments` endpoint doesn't carry it. Use `gh pr view --json reviewThreads` as the source of truth for resolved-vs-not.
- Pagination matters on busy PRs — use `--paginate` on `gh api` calls.
- Git is a fallback only if `jj` is unavailable in the repo.
