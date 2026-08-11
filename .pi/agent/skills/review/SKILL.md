---
name: review
description: Review a Jujutsu revset from a staff-engineering perspective, always dispatching the review to a subagent
---

# review - Revset Review (via subagent)

Review a Jujutsu revset and produce a staff-engineering review. **The actual review is always performed by a subagent** — the top-level agent only resolves the target, dispatches the subagent, and relays its report. This keeps the reviewer independent of whatever work preceded the review and keeps the main context clean.

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

## Why a subagent

Always run the review in a subagent, even for a one-line change. Never review inline in the main conversation.

- **Independence** — a fresh subagent judges the diff on its own merits, unbiased by the reasoning, assumptions, or mistakes that produced the code earlier in this conversation.
- **Context hygiene** — reading full diffs and PR threads is token-heavy; keeping it in the subagent leaves the main context uncluttered.
- **Focus** — the subagent is prompted to do one job well and return a structured verdict.

## Workflow

The top-level agent does steps 1–2, then dispatches step 3. It does **not** read diffs or form findings itself.

1. **Resolve the target revset**
   - If the user gives a revset, use it verbatim.
   - Otherwise default to `trunk()..@`.
   - Validate it resolves to at least one change:
     ```bash
     jj log -r '<revset>'
     ```
   - If empty or invalid, report that and stop — don't dispatch a subagent for nothing.

2. **Enumerate the stack**
   - List change IDs in the revset, oldest first, to hand to the subagent:
     ```bash
     jj log -r '<revset>' --no-graph -T 'change_id.short() ++ "\n"'
     ```

3. **Dispatch the review to a subagent**
   - Use the `Agent` tool (subagent type `general-purpose`, or a dedicated code-review agent if one is configured).
   - Pass the subagent the resolved revset and the change IDs from step 2, and instruct it to carry out steps 4–9 below and return its report as its final message.
   - Run a single subagent for the whole revset unless the stack is large and the changes are independent enough that per-change subagents would be clearer — in that case dispatch one subagent per change ID and relay each report.
   - While the subagent runs, do not start reviewing the diff yourself.

4. **Inspect each change's diff** *(subagent)*
   - For every change ID:
     ```bash
     jj show <change-id>
     ```
   - Read the full diff. Don't review from filenames or commit messages alone.
   - Cite **Jujutsu change IDs** in findings, not git commit hashes.

5. **Pull existing PR/MR feedback** *(subagent)*
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

6. **Load the project's review checklist** *(subagent)*
   - Look for a **`REVIEW.md`** at the root of the project this skill is running in (repo root / working directory).
   - If present, read it and treat it as the project's authoritative reviewer checklist. Apply its criteria alongside the generic focus areas below, and cite the relevant `REVIEW.md` section (e.g. "§2.4") in any finding it drives.
   - If absent, proceed with the generic focus areas only.

7. **Staff Engineer review** *(subagent)*

   Focus on:
   - correctness and edge cases
   - reliability and failure modes
   - security and privacy concerns
   - performance/scalability
   - maintainability, readability, and test quality
   - deployment/backward compatibility risks

   Classify findings by severity: **blocker**, **major**, **minor**, **nit**.

8. **Questions for the author** *(subagent)*

   Capture things you'd want confirmed before approving but aren't outright findings — hidden assumptions, unclear intent, missing context. Keep these separate from severity-classified findings.

9. **Final summary** *(subagent returns this as its final message)*
   - Header: revset reviewed, change count, PR/MR link (if any), overall recommendation (`approve`, `approve with follow-ups`, or `changes required`).
   - Findings grouped by severity, each tied to a change ID.
   - Questions section.
   - Note any unresolved existing review threads that block approval.
   - If nothing to flag, say so explicitly.

10. **Relay the report** *(top-level agent)*
    - Present the subagent's report to the user. Lead with caveats/blockers before highlights.
    - If multiple subagents ran, relay each and note the combined recommendation.
    - Don't silently rewrite the subagent's findings — surface them as reviewed.

## Notes

- The review is **always** delegated to a subagent — never produce the review inline, regardless of how small the diff looks.
- Git is a fallback only if `jj` is unavailable in this repo.
- For *fix-it* output (apply changes, not just report them), use `/simplify` instead.
