# Zsh startup performance

Notes from a profiling pass on `zsh/.zshrc` (May 2026).

## Baseline

Warm startup, measured with `/usr/bin/time zsh -i -c exit`:

```
1.07s real
1.06s real
1.43s real (cold)
```

`zmodload zsh/zprof` showed:

```
compinit:  1000ms total across 3 calls   (~90% of startup)
compdump:   511ms                        (rebuilds completion dump)
compdef:    190ms across 2476 calls
mise:        33ms
```

## Root cause

`compinit` was running **three times** per shell:

1. Once inside `oh-my-zsh.sh` (sourced from `.zshrc`).
2. Once conditionally near the top of `zsh/config/zsh.zsh`.
3. Once unconditionally a few lines later in the same file.

oh-my-zsh already runs `compinit` with its own cache logic, so the block in
`zsh.zsh` was pure duplicate work.

Separately, `source <(COMPLETE=zsh jj)` in `.zshrc` was spawning `jj` on every
shell startup to regenerate completions.

## Changes

1. **`zsh/config/zsh.zsh`** — removed the duplicate `compinit` block; kept only
   the menu/`complist`/`globdots` settings. oh-my-zsh's single `compinit` does
   the work.
2. **`zsh/.zshrc`** — cached the jj completion script under
   `$XDG_CACHE_HOME/jj-completion.zsh`. The cache is regenerated only when the
   `jj` binary on `$PATH` is newer than the cached file.

## Result

```
0.93s real (cold — primed jj completion cache)
0.39s real
0.38s real
```

Warm startup dropped from **~1.07s → ~0.38s** (~65% faster).

Post-fix zprof:

```
compinit:  490ms   (1 call; ~200ms of that is profiler overhead)
compdef:   160ms   (828 calls — down from 2476)
_omz_source: 75ms
_mise_hook:  32ms
```

## What's left, and why we stopped

| Hotspot | Time | Lever | Tradeoff |
|---|---|---|---|
| `compinit` + `compdump` | ~310ms | Use `compinit -C` to skip the security audit | Loses the daily integrity check on `$fpath` |
| `compdef` × 828 | 160ms | Drop oh-my-zsh, source `zsh-autosuggestions` / `vi-mode` directly | Larger config rewrite |
| `_omz_source` | 75ms | Same as above | Same |
| `_mise_hook` | 32ms | Lazy-load mise (only activate on `cd` into a managed project) | Mise-managed tools wouldn't be on `$PATH` until first directory hook fires |

Sub-200ms startup is reachable, but only by dropping oh-my-zsh. Stopped at
~380ms as a reasonable balance of effort vs. payoff.

## How to re-profile

```sh
# Wall-clock
for i in 1 2 3; do /usr/bin/time zsh -i -c exit 2>&1 | tail -1; done

# Per-function breakdown
zsh -i -c 'zmodload zsh/zprof; source ~/.zshrc; zprof' | head -30
```
