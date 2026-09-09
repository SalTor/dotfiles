---
name: wiki
description: Read or edit `~/wiki`, the shared LLM-maintained knowledge base. Covers the workspace layout, the compare-and-swap protocol for moving `main` when several agents write at once, and the sandbox and colocation traps.
---

# wiki - the shared knowledge base

`~/wiki` holds domain knowledge that belongs to no single repo: contracts between services,
findings from live systems, meeting outcomes, research, and plans spanning more than one
codebase. Repo-scoped knowledge stays in that repo's own docs and specs.

Remote is `origin` (`Fast-Growing-Trees-LLC/wiki-experiment`). Always work on `main`. No
pull requests, no `saltor/` bookmarks, which overrides `~/code/workspaces/AGENTS.md` for
`~/wiki` only.

**`~/wiki/AGENTS.md` is the authority on content**: the layer model (`raw/` is immutable,
pages state current truth, `log.md` carries decisions only, `agenda.md` is local), page
style, `log.md` prefixes, and the ingest / query / agenda / lint operations. Read it before
writing a page. This skill owns the mechanics only.

## Reading needs no workspace

Read straight from `~/wiki`. Start at `index.md`, then the pages it points to, then the
tail of `log.md` for anything recently reversed. A fact already recorded there does not
need re-deriving from a live system.

## Editing needs a workspace

Several agents write this repo at once: other sessions on this machine, and teammates'
agents in the cloud. Assume `main` has moved since you last looked. `~/wiki` itself is the
human's Obsidian vault and the default workspace, so editing there drops your snapshot into
whatever commit they are holding.

    mkdir -p ~/code/workspaces/wiki
    cd ~/wiki
    jj git fetch
    jj workspace add --name wiki-<slug> -r main ~/code/workspaces/wiki/<slug>

A workspace isolates the working copy. It does **not** isolate `main`, which is a single
pointer in one shared store:

    ~/wiki                 default workspace, the Obsidian vault
      |  .jj/repo + .git   ONE store, ONE `main` pointer
      +-- workspace A      own working copy
      +-- workspace B      own working copy

## Landing a change

One change, one commit, one push. Never end a turn with wiki edits uncommitted.

    jj describe -m "docs(<subject>): ..."
    jj bookmark move main --to @        # CAS 1
    jj git push --bookmark main         # CAS 2

The `docs(<subject>): ...` form is imposed by the wiki, so use it here even though jj
descriptions are plain prose everywhere else.

Do not add `jj new`. The push makes that commit immutable, so jj creates the next working
copy commit itself and reports doing so; an explicit `jj new` afterwards only leaves a
second empty commit behind. Pushing before the working copy moves also keeps recovery
simple, since `@` is still the commit that needs rebasing.

Both middle steps are compare-and-swap. Neither can clobber; both fail loudly.

| step | guards against | failure looks like |
|---|---|---|
| `jj bookmark move main --to @` | another local workspace moved `main` first | `Refusing to move bookmark backwards or sideways: main` |
| `jj git push --bookmark main` | a cloud agent pushed first | non-fast-forward rejection |

No agent is elected to move `main`. Whoever arrives first wins, the loser is told, and the
queue is arrival order at CAS 1. Recover according to which one failed:

| failed at | recovery |
|---|---|
| CAS 1 | `jj git fetch`, `jj rebase -s @ -d main`, then move and push again |
| CAS 2 | `jj git fetch`, `jj rebase -s @ -d main@origin`. `main` already points at your commit and follows it through the rewrite, so push again directly |

Retry at most three times. Then stop and report, leaving the commit in the workspace for a
human. Do not loop.

## The one flag that must never be used here

`--allow-backwards` (`-B`) on `main`, whether via `jj bookmark move` or `jj bookmark set`.
The refusal is the safety mechanism: it means another agent's commit is on `main` and yours
does not descend from it. Forcing past it strands their work off `main`'s ancestry
silently, and nothing downstream reports it. Rebase instead.

## Traps

**Every `jj` command here needs the sandbox bypass.** File edits inside
`~/code/workspaces/wiki/<slug>` run in-sandbox, but the store lives under `~/wiki`, so even
`jj st` fails with `Could not create named temp file in '/Users/storcivia/wiki/.git/objects'`.
That is the sandbox, not a damaged repo.

**A push from a workspace leaves the vault's git refs stale.** `~/wiki` is colocated, so
`.git` carries its own `main`. After pushing from a workspace,
`jj bookmark list --all-remotes` in `~/wiki` reports `@git (behind by 1 commits)` and
Obsidian or any git tool still sees the old state. Run `jj git export` in `~/wiki` to
resync.

**`index.md` and `log.md` conflict on nearly every concurrent change.** Both are shared and
append-shaped. Keep both sides' rows; `log.md` is newest first.

**Check before creating a page.** Another agent may have filed the subject while you
worked. After every fetch, re-read `index.md` and `rg` the vault. Two pages asserting the
same fact will drift, so link rather than duplicate.

## Cleanup

    cd ~/wiki
    jj workspace forget wiki-<slug>
    rm -rf ~/code/workspaces/wiki/<slug>
