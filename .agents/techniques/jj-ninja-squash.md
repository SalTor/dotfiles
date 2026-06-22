# jj ninja-squash: split a commit by constructing the intermediate state

A technique for splitting one `jj` commit into two when the seam doesn't fall on whole-hunk boundaries — e.g. when a single import line removes an old name and adds a new name in the same hunk, and you want those changes in different commits.

## When to reach for it

- The commit you want to split has changes that are entangled at the **line** level, not just the file or hunk level.
- `jj split -i` (interactive editor) and `jjc pick` (path/hunk-based) can't cleanly separate the seam because each hunk does more than one semantic thing.
- You can *describe* the intermediate state easily (e.g. "the file should look like X, halfway between its pre-commit state and the final state") — even if you can't *extract* it from the existing hunks.

## How it works

The idea: instead of trying to extract the early-portion *forward* from the final state, you go to the final state, manually carve out the intermediate state, then use a revert to recover the late-portion as its own commit.

### Walkthrough with named commits

Starting state. `B` is the big commit to split into an "early" portion and a "late" portion:

```
A ─ B
```

**Step 1.** `jj new B` — create empty commit `C` on top of `B`.

```
A ─ B ─ C
```

**Step 2.** Edit `C` so its content matches the intermediate state you want (i.e. the early portion alone). This is usually deletions — "remove the late stuff from `B`" — but it can include edits where the seam rewrites a shared line.

```
A ─ B ─ C
        diff: removes (or rewrites) the late stuff
        content: early portion only
```

**Step 3.** Revert `C` on top of itself — `jj revert -r C --insert-after C` (or whatever the current jj command is for placing a backout commit) creates `D`, whose diff is the inverse of `C`'s. `D`'s content equals `B`'s content (original final state).

```
A ─ B ─ C ─ D
            diff: +late stuff (inverse of C)
            content: original B (early + late)
```

**Step 4.** Squash `C` into its parent `B`. `B` absorbs `C`'s diff and becomes `B'` (early-only). `C` is now empty and can be abandoned. `D` rebases to be child of `B'`.

```
A ─ B' ─ D
   (early)  (diff: +late, content: original B)
```

You're done. `B'` is the early commit; `D` is the late commit. Content at `D` is identical to the original `B`.

## Worked example

You have a commit that introduces a new API and converts callers in one shot. Each consumer file has one import line like:

```ts
// before commit
import { oldFn } from "~/lib/old-path";
// after commit
import { newFn } from "~/lib/new-path";
```

The line rewrite conflates two changes (path move + API rename). `jjc pick` can't split sub-hunk lines. To get a 2-commit story — "(1) relocate, (2) rename" — apply ninja-squash:

1. `jj new <commit>` → `C`.
2. In each consumer, rewrite the import to the intermediate state — old name, new path:

   ```ts
   import { oldFn } from "~/lib/new-path";
   ```

   Also restore each callsite to use `oldFn` (i.e. undo the rename in the body too).

3. `jj revert -r @` → `D` re-applies the rename changes (path + body) on top.
4. `jj squash` to fold `C` into the original commit. End state: relocate commit + rename commit, both compile standalone.

## Pitfalls

- **The intermediate state has to be valid.** `C`'s code must compile/lint/test on its own. If you can't construct a compiling intermediate, the split isn't meaningful and the technique can't help. For the API-relocation example above, the new path has to actually export the old names for the intermediate to compile — verify this before starting.
- **Revert direction.** `jj revert -r C` creates a commit whose diff is `parent(C) → C` inverted. Check the placement flag (`--insert-after`, `--destination`, etc.) for your jj version so `D` ends up as `C`'s child, not somewhere else.
- **Tests/snapshots can complicate things.** If `C` modifies behavior, snapshots in `C` need to match the intermediate state, not the final state. Usually means restoring snapshot files from the pre-commit state too.
- **Don't squash before revert.** The order matters: revert first (so `D` captures the inverse), then squash. Squashing first leaves nothing to revert against.
