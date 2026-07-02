---
name: review
description: Review a Jujutsu revset from a staff-engineering perspective
---

# review - Revset Review

Review a Jujutsu revset and produce a staff-engineering review inline in the conversation.

## Usage

```text
/review [revset]
```

Examples:
- `/review` → defaults to `trunk()..@`
- `/review @`
- `/review @-`
- `/review nwr`
- `/review trunk()..feature-bookmark`

If no revset is given, default to `trunk()..@`.

## Workflow

1. **Resolve the target revset**
   - If the user gives a revset, use it verbatim.
   - Otherwise default to `trunk()..@`.
   - Validate it resolves to at least one change:
     ```bash
     jj log -r '<revset>'
     ```
   - If empty or invalid, report that and stop.

2. **Enumerate the stack**
   - List change IDs in the revset, oldest first:
     ```bash
     jj log -r '<revset>' --no-graph -T 'change_id.short() ++ "\n"'
     ```
   - For a single-change revset this is one ID; for a stack, you'll review each in turn.

3. **Inspect each change's diff**
   - For every change ID from step 2:
     ```bash
     jj show <change-id>
     ```
   - Read the full diff. Don't review from filenames or commit messages alone.
   - Cite **Jujutsu change IDs** in findings, not git commit hashes.

4. **Pull existing PR/MR feedback**
   - If a PR/MR exists for the revset, fetch its comments first so the review doesn't duplicate ongoing discussion.
   - Detect the forge from origin:
     ```bash
     jj git remote list
     ```
   - Fall back to `git remote get-url origin` only if `jj` is unavailable.
   - **GitHub** (`gh`) — run from the bookmark's branch, or pass `<number>`:
     ```bash
     # PR metadata + top-level conversation + review threads (with resolution state)
     gh pr view [<number>] --json number,url,title,state,reviews,reviewThreads,comments
     # Inline code-review comments with file/line anchors
     gh api repos/{owner}/{repo}/pulls/{number}/comments
     ```
   - **GitLab** (`glab`):
     ```bash
     glab mr view [<iid>] --comments
     ```
   - When forming findings:
     - Skip anything already raised by a reviewer, **including resolved threads** — don't relitigate decided issues.
     - If you'd reinforce or push back on an existing comment, call out the thread explicitly ("agree with X's comment on `<file>:<line>`") rather than restating it as a fresh finding.
     - Note unresolved threads the author hasn't addressed yet so the recommendation reflects them.
   - If no PR/MR exists (pre-push or local-only stack), skip this step and say so.

5. **Load the project's review checklist**
   - Look for a **`REVIEW.md`** at the root of the project this skill is running in (repo root / working directory).
   - If present, read it and treat it as the project's authoritative reviewer checklist. Apply its criteria alongside the generic focus areas below, and cite the relevant `REVIEW.md` section (e.g. "§2.4") in any finding it drives.
   - If absent, proceed with the generic focus areas only.

6. **Staff Engineer review**

   Focus on:
   - correctness and edge cases
   - reliability and failure modes
   - security and privacy concerns
   - performance/scalability
   - maintainability, readability, and test quality
   - deployment/backward compatibility risks

   Classify findings by severity: **blocker**, **major**, **minor**, **nit**.

7. **Questions for the author**

   Capture things you'd want confirmed before approving but aren't outright findings — hidden assumptions, unclear intent, missing context. Keep these separate from severity-classified findings.

8. **Final summary**
   - Header: revset reviewed, change count, PR/MR link (if any), overall recommendation (`approve`, `approve with follow-ups`, or `changes required`).
   - Findings grouped by severity, each tied to a change ID.
   - Questions section.
   - Note any unresolved existing review threads that block approval.
   - If nothing to flag, say so explicitly.

## Notes

- Git is a fallback only if `jj` is unavailable in this repo.
- For *fix-it* output (apply changes, not just report them), use `/simplify` instead.
