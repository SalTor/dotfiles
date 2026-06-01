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
   - **Subject line**: short, imperative, plain prose. **Do not use Conventional Commit prefixes** (`feat(...)`, `fix(...)`, `chore(...)`, etc.) — those are reserved for PR titles. A jj change description is for the change itself, not a packaged release artifact. Even if `git log` / `jj log` shows recent commits in Conventional Commit format, treat those as squashed PR titles, not a style to mirror on per-change descriptions.
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
- **No Conventional Commit prefixes** on jj change descriptions. The `pr` skill applies that style to PR/MR titles by default. If a description needs scope context, work it into the prose (e.g. "drop the leading zero on minutes in the delivery-promise countdown") rather than a `feat(delivery-promise): ...` prefix.
- Don't push or open a PR as part of this skill — describing is the whole job. Use `/pr` for that.
