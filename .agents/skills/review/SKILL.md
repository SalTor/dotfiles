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

4. **Staff Engineer review**

   Focus on:
   - correctness and edge cases
   - reliability and failure modes
   - security and privacy concerns
   - performance/scalability
   - maintainability, readability, and test quality
   - deployment/backward compatibility risks

   Classify findings by severity: **blocker**, **major**, **minor**, **nit**.

5. **Questions for the author**

   Capture things you'd want confirmed before approving but aren't outright findings — hidden assumptions, unclear intent, missing context. Keep these separate from severity-classified findings.

6. **Final summary**
   - Header: revset reviewed, change count, overall recommendation (`approve`, `approve with follow-ups`, or `changes required`).
   - Findings grouped by severity, each tied to a change ID.
   - Questions section.
   - If nothing to flag, say so explicitly.

## Notes

- Git is a fallback only if `jj` is unavailable in this repo.
- For *fix-it* output (apply changes, not just report them), use `/simplify` instead.
