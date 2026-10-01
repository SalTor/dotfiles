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
   - **Subject line**: follow [Scoped Commits](https://scopedcommits.com/): `<scope>: <description>`. The scope is the subsystem, area, or module the change touches, and it comes first because it is what a reader scanning the log needs. The description is short, imperative, lowercase, with no trailing period.
     ```
     consumer-api: drop the leading zero on countdown minutes
     delivery-promise, checkout: share the cutoff calculation
     treewide: rename ShipDate to PromiseDate
     ```
   - **Choosing the scope**: take the narrowest area that covers the whole diff, using the names the repo already uses for its directories, packages, or services. Nest with a second colon when it helps (`consumer-api: sentry: ...`). If the change spans several areas, use a broader scope that covers them all, or list them separated by commas. Use `treewide` for changes that touch the whole tree. A diff that is documentation only or tests only can use `docs` or `tests` as its scope.
   - **Tickets** go in parentheses after the scope (`auth (ET-1234): ...`) or in a trailer. Leave spec/decision markers off the subject; the `pr` skill puts those on the PR/MR title.
   - **No Conventional Commit types on a change.** Never write `feat(...)`, `fix(...)`, `chore(...)`; those belong on the PR/MR title only.
   - **Whatever style `git log` / `jj log` shows, do not mirror it.** On a squash-merge repo every commit on the trunk *is* a PR title, so the log is evidence of the PR convention and says nothing about per-change style. Check for the `(#123)` suffix: if it's there, you're reading a squashed PR title. Look at the trunk log for scope *names* the repo uses, not for the format.
   - **Body** (when the change is non-trivial): explain the bug or motivation, the mechanism of the fix, and any follow-up considerations. Wrap at ~72 cols.
   - Don't invent a body for a one-line mechanical change — a subject is enough.

4. **Apply with `jj describe`**
   ```bash
   jj describe <rev> -m "scope: subject

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
- **Scoped Commits on changes, Conventional Commits on the PR title.** A change reads `consumer-api: delivery: ...`, never `feat(delivery-promise): ...`, and never a trailing `[spec:20260804-i59z]`. The `pr` skill derives the Conventional Commit title from these scopes.
- Don't push or open a PR as part of this skill — describing is the whole job. Use `/pr` for that.
