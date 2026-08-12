---
name: rebase
description: Rebase the current Jujutsu bookmark onto the latest trunk (main@origin) and resolve any conflicts — then verify the rebase didn't silently keep stale or upstream-deleted content, since a conflict-free rebase is not proof of a correct one
---

# rebase - Rebase onto latest trunk

Fetch the latest trunk, rebase the working bookmark onto it, resolve any conflicts, and **verify the result**. Jujutsu-native (`jj`), with git fallbacks. The load-bearing part of this skill is step 6: a conflict-free rebase is *not* proof of a correct rebase.

## Usage

```
/rebase [trunk]
```

- `/rebase` → rebase the bookmark on `@` (or its nearest ancestor bookmark) onto `main@origin`
- `/rebase master` / `/rebase develop` → use a different trunk bookmark

## Before you rebase — is it even the right move?

- **Merge-queue repos:** rebasing is usually not needed for mergeability — the queue rebases at merge time. Rebase when your branch predates changes that alter what its diff should be, or when you want a cleaner review diff. State which reason applies so the user isn't surprised by a force-push.
- **Uncommitted work in `@`:** if `@` carries in-progress edits, rebase the bookmark and reconcile those edits by hand rather than relocating `@` wholesale.

## Workflow

1. **Detect the trunk bookmark / remote**
   ```bash
   jj git remote list   # confirms origin; recovers the repo slug in .git-less jj workspaces
   ```
   Default trunk is `main@origin` unless the user names another or the repo clearly uses `master`/`develop`.

2. **Fetch trunk** (updates remote-tracking bookmarks; leaves the working copy alone)
   ```bash
   jj git fetch
   ```

3. **Resolve the bookmark to rebase, and check whether a rebase is even needed**
   ```bash
   # bookmark on @, or walk back to the nearest ancestor that has one
   jj log -r '::@ & bookmarks()' --no-graph -T 'change_id.short() ++ " " ++ bookmarks ++ "\n"'

   # already on latest trunk? non-empty result = nothing to do, stop here
   jj log -r '<bookmark> & descendants(<trunk>@origin)' --no-graph -T 'commit_id.short()'

   # show the gap you're about to close
   jj log -r '<trunk>@origin | <bookmark>' --no-graph \
     -T 'change_id.short() ++ " " ++ commit_id.short() ++ if(bookmarks," ["++bookmarks++"]") ++ " | " ++ description.first_line() ++ "\n"'
   ```
   If `jj git fetch` prints `Nothing changed` **and** the descendants check is non-empty, the branch is already current — report that and stop.

4. **Rebase the bookmark onto trunk**
   ```bash
   jj rebase -b <bookmark> -d '<trunk>@origin'
   ```
   - Use `-b` (whole bookmark + descendants, e.g. the empty `@` on top), not `-r` (a single commit, which orphans the rest).
   - Note the `Rebased N commits` line.

5. **Resolve conflicts, if any**
   ```bash
   jj resolve --list
   ```
   - `jj` materializes conflicts as `<<<<<<<` … `+++++++ <side>` (one side's content) … `%%%%%%%` (a *diff* between base and the other side, with `-`/`+`/space lines) … `>>>>>>>`. It is **not** the plain git `<<<<<<< / ======= / >>>>>>>` shape — read it before editing.
   - **Marker-corruption trap:** if you replace only *part* of a materialized block, the trailing context lines survive with a one-space indent and a stray `>>>>>>> conflict … ends` marker is left behind. After resolving, always sweep:
     ```bash
     grep -rnE '^(<<<<<<<|>>>>>>>|%%%%%%%|\+\+\+\+\+\+\+|conflict [0-9]+ of)' <files>
     ```
     then strip the accidental leading space from the affected range.
   - For a whole-section "take theirs" / "take mine," prefer re-deriving the file (`jj restore --from <rev> <path>`, or reconstruct with Edit) over hand-editing markers — it avoids the corruption entirely.
   - If you resolved in a child working-copy commit, fold it back:
     ```bash
     jj squash
     ```

6. **VERIFY THE REBASE — a clean, conflict-free rebase is NOT proof of a correct one.**
   This step is easy to skip and where silent breakage gets through. Two failure modes, neither of which raises a conflict marker:

   - **(a) Upstream-deleted content your branch re-adds.** If trunk deleted a file or doc section your branch's diff still contains, the rebase keeps your copy with no conflict, so content removed upstream is present again in your branch. (This PR hit exactly that: a README section a trunk commit had stripped reappeared after a conflict-free rebase.) Guard against it:
     ```bash
     jj diff -r <bookmark> --stat        # is the scope still only what you intended?
     ```
     For anything your diff still references, confirm trunk didn't remove it — e.g. does a script/symbol/path your docs mention still exist in the tree, and does `<trunk>@origin`'s copy of a file you both touched still contain the block you're carrying?
     ```bash
     jj file show -r '<trunk>@origin' <path> | grep -n '<thing you carry>'
     ```
   - **(b) Semantic drift.** Trunk renamed or changed an API/env var/script your diff still uses in its old form — no textual conflict, now wrong. Typecheck and tests catch most of this; run them (steps 7–8).

7. **Reinstall dependencies — under the repo's pinned toolchain — before trusting any build/typecheck/test**
   The base moved, so the lockfile likely did too. Stale `node_modules` / generated types throw confusing errors in files you never touched; reinstall first rather than editing code to chase them.
   ```bash
   pnpm i     # or npm i / bun i / uv sync, per the repo
   ```
   Run the install (and the checks) under the Node/toolchain the repo pins (mise/asdf/nvm), not a stray system version. Installing under the wrong Node fetches platform-native bindings for the wrong runtime, so tools like oxlint / rolldown / esbuild then fail with `Cannot find native binding` — a crash that reads like a code bug but is an install artifact. If a `mise exec` wrapper doesn't stick for nested spawns, put the pinned bin first on `PATH`:
   ```bash
   export PATH="$(dirname "$(mise which node)"):$PATH"
   ```

8. **Re-verify** with the project's own checks (typecheck, lint, tests, build). If errors surface in untouched files right after the rebase, that's the stale-deps tell — reinstall and re-run before diagnosing.

9. **Push** (only if the bookmark was already pushed)
   ```bash
   jj git push --bookmark <bookmark>
   ```
   Moves the remote bookmark sideways (jj handles the force safely). Nothing else needed for merge-queue repos.

## Notes / Learned behavior

- **Clean rebase ≠ correct rebase.** The failure that matters here is silent: trunk removed something, your branch re-adds it, no conflict fires. Always diff the rebased branch against trunk and sanity-check the file scope before pushing.
- **Reinstall deps after any nontrivial base move** before trusting typecheck/build — and when errors appear in files you didn't touch, suspect stale deps first.
- **Install and run under the repo's pinned Node/toolchain.** A rebase that also bumped tooling (e.g. a bundler swap) surfaces `Cannot find native binding` from oxlint/rolldown/esbuild when `node_modules` was installed under a stray system runtime. Reinstall under the pinned version instead of debugging the code.
- **`jj` conflict markers ≠ git's.** Expect `+++++++` (a side) and `%%%%%%%` (a diff), and grep for leftover markers + fix one-space-indented context after hand-resolving.
- Prefer `jj rebase -b <bookmark>` over `-r` so descendants (including the empty `@`) come along.
- **Merge queue:** rebase for content-correctness or review clarity, not to satisfy mergeability the queue already handles — and say which, since it's a force-push.
- Re-run `/check-feedback` after pushing if the branch has an open PR/MR — a rebase can invalidate line anchors on existing review threads.
