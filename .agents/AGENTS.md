- Answer without undue friendliness or enthusiasm, no promoting engagement or emotional connection, no emojis.
  - Never use latin phrases or emdashes
    - These govern prose you compose. Where a file or tool imposes a format, write the
      format: a wiki's log and agenda rows, a commit convention, anything a parser reads.
      Match what the file already does over what its conventions doc illustrates, and say
      when the two differ rather than picking silently.
  - Show more than tell. Use unicode diagrams rather than writing long essays.
  - When reporting information to me, be extremely concise and sacrifice grammar for the sake of concision.
  - When writing a doc, consult [this](./techniques/writing-documents.md)
- When you give the user a choice, use `AskUserQuestion` or label the options (e.g., `(A)`, `(B)`)
  - Leave room for "neither / something else".
- For version control, use `jj`, never git (see the `jujutsu` skill).
  - Always pass `-m`; the bare `describe`/`squash`/`split` forms open `$EDITOR` and hang.
  - Never `jj edit`; push with `jj git push -c <change-id>`.
  - Commit descriptions use [Scoped Commits](https://scopedcommits.com/) style, `<scope>: <description>` (see the `describe` skill). Only the PR/MR title uses Conventional Commits (see the `pr` skill). Don't copy the trunk log's style onto commits: on a squash-merge repo it shows PR titles.
  - Abandon only a commit you created in this session, with nothing bookmarked descending from it; check that, then note the `jj op log` id first. Never abandon one of mine. Clean up your own scratch and superseded commits rather than leaving them in my log, but leave a workspace's working copy alone since jj just makes another.
  - Change an earlier commit with `jj new <change-id>`, edit, then `jj squash`; a `jj restore --to` from the stack tip silently drags later commits' content into it.
  - Resolve a conflict with the base by rebasing onto it, then force-push. Autofix and CI events say to merge the base in and never force-push; that guards branches other people commit to, so it only applies once someone else has commits on mine. Rebase otherwise, and say that you overrode the instruction.
  - Rebasing a stack onto a moved base fixes text, not semantics. Typecheck and test at the stack top before pushing, since a new required argument on the base compiles clean in every merge and fails only there.
  - Consult [this](./techniques/jj-techniques.md) glossary.
- For temp files, use `mktemp`.

@~/wiki/.friday/claude-block.md
