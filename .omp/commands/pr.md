---
name: pr
description: Create a pull/merge request (GitHub or GitLab) using Jujutsu workflows
---

# pr - Create a Pull/Merge Request

Create a GitHub PR (`gh`) or GitLab MR (`glab`), defaulting to Jujutsu workflows. This covers reviewing changes, describing the change, pushing a bookmark, creating the PR/MR, and formatting the body without literal `\n` characters.

## Usage

```
/pr [base-branch]
```

Examples:
- `/pr main`
- "open a PR" (defaults to repo conventions; ask for base if missing)

## Workflow

1. **Determine repo root**
   - Use current working directory or the repo containing recent file edits.

2. **Detect forge and CLI**
   - Check origin remote host:
     ```bash
     git remote get-url origin
     ```
   - If host is GitHub, use `gh`.
   - If host is GitLab, use `glab`.
   - Verify auth before creation:
     ```bash
     gh auth status
     glab auth status
     ```
   - If unauthenticated, ask user to authenticate before continuing.

3. **Review current change (align with review prompt)**
   ```bash
   jj status
   jj diff -r @ --color never
   ```
   - If `jj` fails, fall back to:
     ```bash
     git status -sb
     git diff --color=never
     ```

4. **Preserve JJ change descriptions unless explicitly asked to rewrite them**
   - Do not rewrite stack/change descriptions into Conventional Commit format by default.
   - Prefer keeping existing JJ descriptions as-is when opening a PR/MR.
   - Use Conventional Commit style for the PR/MR title unless the user asks for a different style.
   - Only update a JJ change description if the user explicitly requests it or if the current description is clearly unusable for review.

5. **Create or reuse a bookmark (branch)**
   - If none exists, create one for `@`:
     ```bash
     jj bookmark create <name> -r @
     ```
   - If pushing a new bookmark, track it before pushing:
     ```bash
     jj bookmark track <name> --remote origin
     ```
   - Prefer `saltor/` prefix for bookmark names.

6. **Push the bookmark**
   ```bash
   jj git push --bookmark <name>
   ```

7. **Check for a PR/MR template**
   - Look for template files in this order:
     - `docs/pull-request-template.md`
     - `pull-request-template.md`
     - `.github/pull_request_template.md`
     - `.github/PULL_REQUEST_TEMPLATE.md`
     - `.github/PULL_REQUEST_TEMPLATE/`
     - `PULL_REQUEST_TEMPLATE.md`
   - If a template exists, follow its structure exactly in the body.

8. **Create PR/MR**
   - Ask for base branch if not provided.
   - Use a well-formed title/body.
   - **Avoid literal `\n` rendering issues** by using ANSI-C quoting or a here-doc.

   **GitHub (`gh`)**
   ```bash
   gh pr create --base <base> --head <name> \
     --title "<title>" \
     --body $'## Summary\n- item\n\n## Testing\n- command'
   ```

   **GitLab (`glab`)**
   ```bash
   glab mr create \
     --source-branch <name> \
     --target-branch <base> \
     --title "<title>" \
     --description $'## Summary\n- item\n\n## Testing\n- command'
   ```

9. **If body renders incorrectly, update it in-place**
   - GitHub:
     ```bash
     gh pr edit <number> --body $'...'
     ```
   - GitLab:
     ```bash
     glab mr update <iid> --description $'...'
     ```

## Notes / Learned Behavior

- `gh pr create --body "text\nmore"` can render literal `\n`; use ANSI-C quotes or here-doc.
- Use the same approach with `glab mr create --description` to keep formatting reliable.
- When including code examples in the body, wrap in triple backticks.
- Prefer Jujutsu for VCS operations (describe, bookmark, track, push).
- Conventional Commit style applies to the PR/MR title by default, not to JJ change descriptions.
- Ask for base branch if not specified; default to `main` only when appropriate.
- In repos with `docs/pull-request-template.md`, prefer that template over GitHub defaults.
