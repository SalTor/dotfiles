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
- `/pr main "fixes the 403 by dropping the country rule; edge B only"` (your notes; skips the ask)
- "open a PR" (defaults to repo conventions; ask for base if missing)

## Workflow

1. **Determine repo root**
   - Use current working directory or the repo containing recent file edits.

2. **Detect forge and CLI**
   - Check origin remote host. Prefer the Jujutsu-native command, which lists each remote and its URL:
     ```bash
     jj git remote list
     ```
   - Fall back to git if needed:
     ```bash
     git remote get-url origin
     ```
   - This is also how to recover the canonical repo slug for `gh --repo <owner>/<name>` in JJ workspaces without a `.git` directory, where `gh` cannot infer the repo from local git context.
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

8. **Ask the user to describe the change in their own words first**
   - Before drafting anything, ask once for the user's own account of the change, then stop for the answer. Rough is the point: bullets, fragments, one line. No formatting, no template, no polish.
   - Phrase it as a starting point, e.g. "Before I draft the body — how would you describe this change? Rough notes are fine, or say 'you write it' and I'll draft from the diff."
   - Skip the ask when the user already gave their framing: notes passed to `/pr`, a spec or issue they pointed at, or an explanation earlier in the conversation. Use that.
   - Accept a pass. If they decline or say go ahead, draft from the diff and the JJ change descriptions and move on. Do not ask twice.

9. **Build the body on the user's words**
   - Their notes are the source of intent. Keep their framing, their emphasis, and above all their *why* — the diff cannot supply that, and smoothing it into neutral summary prose loses it.
   - Fill the template's remaining sections from evidence: files touched, commands run, spec/issue IDs, screenshots.
   - Match their scale. Three bullets of notes make a three-bullet Summary. Do not pad to fill headings; leave inapplicable template sections empty or drop them.
   - Flag your additions. When the draft asserts something the user did not say — a risk, a rollback note, a claim about behavior — point it out when you show them the draft so they can correct it.
   - This governs the PR/MR body only. It is not license to rewrite JJ change descriptions (see step 4).

10. **Create PR/MR**
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

11. **If body renders incorrectly, update it in-place**
    - GitHub:
      ```bash
      gh pr edit <number> --body $'...'
      ```
    - GitLab:
      ```bash
      glab mr update <iid> --description $'...'
      ```

## Notes / Learned Behavior

- Ask for the user's own description before drafting. A body written only from a diff describes what changed and guesses at why; their notes are the only reliable source of intent.
- `gh pr create --body "text\nmore"` can render literal `\n`; use ANSI-C quotes or here-doc.
- Use the same approach with `glab mr create --description` to keep formatting reliable.
- When including code examples in the body, wrap in triple backticks.
- Prefer Jujutsu for VCS operations (describe, bookmark, track, push).
- Use `jj git remote list` to find the remote/host (and recover the repo slug for `gh --repo`) rather than relying on git remote discovery.
- Conventional Commit style applies to the PR/MR title by default, not to JJ change descriptions.
- Ask for base branch if not specified; default to `main` only when appropriate.
- In repos with `docs/pull-request-template.md`, prefer that template over GitHub defaults.
