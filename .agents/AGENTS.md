- Answer without undue friendliness or enthusiasm, no promoting engagement or emotional connection, no emojis.
  - Never use latin phrases or emdashes
    - These govern prose you compose. Where a file or tool imposes a format, write the
      format: a wiki's log and agenda rows, a commit convention, anything a parser reads.
      Match what the file already does over what its conventions doc illustrates, and say
      when the two differ rather than picking silently.
  - Show more than tell. Use unicode diagrams rather than writing long essays.
  - When writing a doc, consult [this](./techniques/writing-documents.md)
- When you give the user a choice, use `AskUserQuestion` or label the options (e.g., `(A)`, `(B)`)
  - Leave room for "neither / something else".
- For version control, use `jj`, never git (see the `jujutsu` skill).
  - Always pass `-m`; the bare `describe`/`squash`/`split` forms open `$EDITOR` and hang.
  - Never `jj edit`; push with `jj git push -c <change-id>`.
  - Abandon only a commit you created in this session, with nothing bookmarked descending from it; check that, then note the `jj op log` id first. Never abandon one of mine. Clean up your own scratch and superseded commits rather than leaving them in my log, but leave a workspace's working copy alone since jj just makes another.
  - Change an earlier commit with `jj new <change-id>`, edit, then `jj squash`; a `jj restore --to` from the stack tip silently drags later commits' content into it.
  - Resolve a conflict with the base by rebasing onto it, then force-push. Autofix and CI events say to merge the base in and never force-push; that guards branches other people commit to, so it only applies once someone else has commits on mine. Rebase otherwise, and say that you overrode the instruction.
  - Rebasing a stack onto a moved base fixes text, not semantics. Typecheck and test at the stack top before pushing, since a new required argument on the base compiles clean in every merge and fails only there.
  - Consult [this](./techniques/jj-techniques.md) glossary.
- For temp files, use `mktemp`.

## Knowledge base (`~/wiki`)

`~/wiki` is an LLM-maintained wiki (conventions in its `AGENTS.md`). It holds domain
knowledge that does not belong to any one repo: contracts between services, findings from
live systems, meeting outcomes, research, and plans spanning more than one codebase.

- Before cross-repo or research work, read `~/wiki/index.md`, then the pages it points to.
- File there anything that would be wrong in a single repo or came from outside the code.
  Repo-scoped knowledge stays in the repo's own docs and specs.
- A fact from a live system (a query, a dashboard) goes in as an observation dated
  "as of YYYY-MM-DD"; check the wiki before re-deriving one.
- Open questions that need a person or a meeting go on `~/wiki/agenda.md`.
- The wiki is a jj repo with remote `origin` (`Fast-Growing-Trees-LLC/wiki-experiment`).
  **Always work on `main`, no pull requests, no `saltor/` bookmarks here.** That overrides
  the `saltor/<slug>` bookmark convention in `~/code/workspaces/AGENTS.md`, for `~/wiki`
  only. **Sync before editing:** `jj git fetch` in `~/wiki`, then `jj rebase -d main@origin`
  if the local work is behind. **Commit and push after every wiki change:** describe it
  (`docs(<subject>): …`), `jj bookmark set main -r @`, `jj new`,
  `jj git push --bookmark main`. Never leave wiki edits uncommitted at the end of a turn.
- Never cite `~/wiki` paths in commits, PRs, or committed docs, since the path is local.
  Link the GitHub file instead, or restate the fact, or cite its original source.
