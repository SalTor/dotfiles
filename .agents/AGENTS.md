# Agent Instructions

## Version control

Use [Jujutsu (jj)](https://github.com/jj-vcs/jj) instead of git for version control operations. Most repos here are colocated jj+git workspaces — prefer `jj` commands (`jj st`, `jj log`, `jj diff`, `jj describe`, `jj new`, `jj git push`) over their git equivalents unless the user explicitly asks for git.
