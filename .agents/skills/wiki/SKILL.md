---
name: wiki
description: The shared knowledge base at `~/wiki`, covering product data, inventory and availability, presell and dropship dates, delivery promises, state restrictions, facilities, and the contracts between redwood, grove/consumer-api and the ETL. Consult it before deriving any of those from code or a live query, however small the question. Also covers editing it: workspaces, the compare-and-swap protocol for moving `main`, and the stale-root and sandbox traps.
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

## Reading: the vault tree is probably stale

`~/wiki` is a working copy that does **not** follow `main`. Every push from a workspace
leaves it behind, so reading a file there gives you the vault as of whatever commit the root
happens to sit on, with no warning that it is old. Check first:

    cd ~/wiki && jj st        # compare the parent commit against `main`

If the parent is not `main` and `jj st` says the working copy has no changes, advance it
with `jj new main`. If `jj st` lists changes, those are the human's uncommitted edits: leave
the root alone and read the current content at a revision instead, with
`jj file show -r main <path>`.

Then start at `index.md`, read the pages it points to, and check the tail of `log.md` for
anything recently reversed. A fact already recorded there does not need re-deriving from a
live system.

## Editing needs a workspace

Several agents write this repo at once: other sessions on this machine, and teammates'
agents in the cloud. Assume `main` has moved since you last looked. `~/wiki` itself is the
human's Obsidian vault and the default workspace, so editing there drops your snapshot into
whatever commit they are holding.

    mkdir -p ~/.wiki-workspaces
    cd ~/wiki
    jj git fetch
    jj workspace add --name wiki-<slug> -r main ~/.wiki-workspaces/<slug>
    # already exists?  cd ~/.wiki-workspaces/<slug> && jj workspace update-stale

`~/.wiki-workspaces/` is fixed by the wiki's own `AGENTS.md`, one per agent or task and
reused across sessions. Never put one in a temp or scratchpad directory: when that vanishes
the store keeps a dead entry and the workspace cannot be resumed.

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
`~/.wiki-workspaces/<slug>` run in-sandbox, but the store lives under `~/wiki`, so even
`jj st` fails with `Could not create named temp file in '/Users/storcivia/wiki/.git/objects'`.
That is the sandbox, not a damaged repo.

**A push from a workspace leaves the vault two ways behind.** Its git refs, because `~/wiki`
is colocated and `.git` carries its own `main`, so `jj bookmark list --all-remotes` reports
`@git (behind by 1 commits)`; and its working copy, which never follows `main`. Finish a
change by running `jj git export` and then `jj new main` in `~/wiki`, or the human opens
Obsidian and does not see what you just filed.

**`index.md` and `log.md` conflict on nearly every concurrent change.** Both are shared and
append-shaped. Keep both sides' rows; `log.md` is newest first.

**Check before creating a page.** Another agent may have filed the subject while you
worked. After every fetch, re-read `index.md` and `rg` the vault. Two pages asserting the
same fact will drift, so link rather than duplicate.

**`agenda.md` and `_unfiled/` exist only in the root.** Both are gitignored, so a workspace
has no copy. Edit them in place at `~/wiki`, and note they carry no VCS safety net: two
agents writing one of them at once is last-writer-wins.

## Cleanup

Workspaces are meant to be reused across sessions, so keep yours unless the task is closed
for good. When it is:

    cd ~/wiki
    jj workspace forget wiki-<slug>
    rm -rf ~/.wiki-workspaces/<slug>

`jj workspace forget` is also how you clear an entry whose directory is already gone.
