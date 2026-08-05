---
name: describe
description: Describe a Jujutsu commit by inspecting its diff and writing the description with `jj describe`
---

# describe - Set a description on a JJ change

When the user asks for a commit/change to be described (e.g. "describe this change", "give a description to `jj show abc`", "describe @"), inspect the change's diff and apply a description with `jj describe`.

## Usage

```
/describe [revset]
```

Examples:
- "describe @" → describes the working copy
- "describe nwr" → describes change ID `nwr`
- "describe this change" → describes `@` by default

## Workflow

1. **Resolve the target revision**
   - If the user gives a change ID, short prefix, or revset, use it verbatim.
   - If unspecified, default to `@` (the working copy).

2. **Inspect the diff before writing anything**
   ```bash
   jj show <rev>
   ```
   - Read the diff in full. Don't describe from filenames alone.
   - Note the *why* (intent) as well as the *what* (mechanics) when possible — pull the why from prior conversation context if the user has been discussing it.

3. **Draft the description**
   - **Subject line**: short, imperative, plain prose that just says what the change does. **Do not prefix it with a scope of any kind** — this covers Conventional Commit forms (`feat(...)`, `fix(...)`, `chore(...)`), bare `area:` / `area: subarea:` forms (`consumer-api:`, `consumer-api: sentry:`), and issue/spec/decision markers (`[spec:...]`, `[decision:...]`, `[ET-1234]`). All of those are PR-title style. A jj change description is for the change itself, not a packaged release artifact.
   - Two prefixes are the exception: `docs:` on a change whose diff is documentation only, `tests:` on one whose diff is tests only. A change that touches source alongside either takes no prefix.
   - **Whatever style `git log` / `jj log` shows, do not mirror it.** On a squash-merge repo every commit on the trunk *is* a PR title, so the log is evidence of the PR convention and says nothing about per-change style. Check for the `(#123)` suffix: if it's there, you're reading a squashed PR title. This applies to any prefix flavor you find, not just Conventional Commit ones.
   - **Body** (when the change is non-trivial): explain the bug or motivation, the mechanism of the fix, and any follow-up considerations. Wrap at ~72 cols.
   - Don't invent a body for a one-line mechanical change — a subject is enough.

4. **Apply with `jj describe`**
   ```bash
   jj describe <rev> -m "subject

   body line 1
   body line 2"
   ```
   - Use a multi-line `-m` (the shell preserves newlines inside the quoted string).
   - Don't use `--no-edit` flags; `jj describe -m` doesn't open an editor anyway.

5. **Confirm**
   - The `jj describe` output shows the new subject line — relay it briefly to the user.
   - If `jj` reports rebased descendants, mention that so the user knows downstream changes were updated.

## Notes

- **Never `jj describe` without first reading the diff.** Filenames lie; the diff is the source of truth.
- **Preserve existing descriptions unless the user asks to overwrite.** If the change already has a description, ask before replacing it (unless the user explicitly says "rewrite" or "replace").
- **No scope prefixes of any kind** on jj change descriptions — not `feat(delivery-promise):`, not `consumer-api: delivery:`, not a trailing `[spec:20260804-i59z]`. The `docs:` / `tests:` carve-out above is the only exception. The `pr` skill puts scope, and any spec/decision marker, on the PR/MR title. If a description needs scope context, work it into the prose (e.g. "drop the leading zero on minutes in the delivery-promise countdown").
- Don't push or open a PR as part of this skill — describing is the whole job. Use `/pr` for that.
