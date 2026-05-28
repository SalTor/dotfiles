# Agent Instructions

## Version control

Use [Jujutsu (jj)](https://github.com/jj-vcs/jj) instead of git for version control operations. Most repos here are colocated jj+git workspaces — prefer `jj` commands (`jj st`, `jj log`, `jj diff`, `jj describe`, `jj new`, `jj git push`) over their git equivalents unless the user explicitly asks for git.

## Temporary files

When creating a temporary file or directory, use `mktemp` rather than hardcoding a path under `/tmp`. Capture the path into a variable (`tmp=$(mktemp)` for a file, `dir=$(mktemp -d)` for a directory) and reference it quoted (`"$tmp"`). This avoids collisions between concurrent runs, predictable-path hijacking, and sandbox-write failures; `mktemp` honors `$TMPDIR` by default.
