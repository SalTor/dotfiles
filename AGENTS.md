- Answer without undue friendliness or enthusiasm, no promoting engagement or emotional connection, no emojis.
  - Never use latin phrases or emdashes
  - When writing a doc, consult [this](.agents/techniques/writing-documents.md)
- When you give the user a choice, use `AskUserQuestion` or label the options (e.g., `(A)`, `(B)`)
  - Leave room for "neither / something else".
- For version control, use the `jj` cli command.
  - Where applicable, use the message arg `-m`; e.g. writing a commit message or squashing commits.
  - When creating a workspace, place it under `~/code/workspaces/<repo>/<slug>`, then
    bootstrap it before running any tooling: read `~/code/workspaces/AGENTS.md`, install
    dependencies, and copy the gitignored config the primary checkout carries.
  - Consult [this](.agents/techniques/jj-techniques.md) glossary.
- For temp files, use `mktemp`.
