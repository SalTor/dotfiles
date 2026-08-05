# Agent Instructions

## Answer structure: caveats before highlights

When reporting results, assessments, or reviews, lead with what's wrong, risky, unverified, or limited — before any positive summary. Order:

1. Caveats, failure modes, and anything not tested/verified
2. Open questions or assumptions made
3. Then the highlights / what works

Never open an answer with praise ("Great news!", "This works well") or a success summary. If there are genuinely no caveats, say so explicitly ("No caveats found") rather than skipping straight to the positives.

## Offering choices: never make "yes" ambiguous

When a turn ends on a choice between two or more concrete next actions, do not phrase it as a single either/or sentence where "yes" would be ambiguous. Instead:

- Prefer the `AskUserQuestion` tool so I can select with the keyboard — use it whenever the whole turn hinges on which path I pick.
- If you answer in prose instead (e.g. the choice is embedded mid-explanation and a picker would be heavy), label each option with a bracketed letter — `(A)`, `(B)`, `(C)` — so I can reply with just the letter.

Either way, make the options mutually exclusive, and leave room for "neither / something else" so I'm never boxed in. This applies only to genuine end-of-turn forks between discrete actions — not rhetorical questions or single obvious next steps.

## Markdown: no manual line wraps

Never hard-wrap prose. Each paragraph, bullet, and table row goes on one line however long it gets — the editor soft-wraps it.

Hard wraps make every later edit churn unrelated lines, so diffs stop showing what actually changed. They also invite pointless "match the house wrap width" work, and that width usually turns out not to exist. Prettier and oxfmt default to `proseWrap: preserve`, so nothing re-wraps what you leave unwrapped.

When editing a doc that is already hard-wrapped, unwrap the parts you touch rather than adding more wrapped lines.

## Writing documents: state the fact, don't frame it

This governs prose written into a repo — specs, ADRs, design docs, READMEs. (`Answer structure` above governs what you say back to me in chat; the two are separate.)

- No bold thesis phrase leading a bullet. State the fact instead of announcing it and then repeating it. `- **The list is seeded by classification, not by guessing.** Every header key was classified keep/drop.` is just `- Every header key was classified keep/drop.`
- One fact per line. A bullet carrying three facts becomes a lead line with nested sub-bullets, not a longer sentence.
- Plain connectives. Not "The general rule — X, Y, Z — is the ADR's", not "Front door, in plain language:". Say what the thing is.
- No trailing period on short fragment bullets.
- Cut anything not pulling weight, whole sections included. Length is not thoroughness.
- One fact, one home. If something is already stated elsewhere, link to it rather than restating it.

## Version control

Use [Jujutsu (jj)](https://github.com/jj-vcs/jj) instead of git for version control operations. Most repos here are colocated jj+git workspaces — prefer `jj` commands (`jj st`, `jj log`, `jj diff`, `jj describe`, `jj new`, `jj git push`) over their git equivalents unless the user explicitly asks for git.

### Bug fixes: red test commit, then the fix

When a change fixes a bug, structure it as two revisions so the regression test's value is provable from history:

1. **Red revision** — the test that reproduces the bug, and nothing else. It must _fail_ against the current buggy code.
2. **Fix revision** (child of the red one) — the source change that makes that same test _pass_.

Anyone can then check out the red revision, watch the test fail, move to the fix, and watch it pass — evidence the test actually exercises the bug and the fix actually resolves it. A test committed together with its fix can pass for unrelated reasons, and that can't be distinguished after the fact.

Keep both revisions building/typechecking (only the new test is red at the red revision), and don't squash the pair together before it's reviewed.

### Techniques

- **Splitting a commit at a line-level seam:** when `jj split -i` and `jjc pick` can't cleanly separate the seam because hunks conflate multiple semantic changes, use the [ninja-squash technique](./techniques/jj-ninja-squash.md): create a child commit, carve it down to the desired intermediate state, revert it, then squash the deletion back into the parent. End up with the early portion as the parent and the late portion as a child whose content equals the original.

## Temporary files

When creating a temporary file or directory, use `mktemp` rather than hardcoding a path under `/tmp`. Capture the path into a variable (`tmp=$(mktemp)` for a file, `dir=$(mktemp -d)` for a directory) and reference it quoted (`"$tmp"`). This avoids collisions between concurrent runs, predictable-path hijacking, and sandbox-write failures; `mktemp` honors `$TMPDIR` by default.

## Reinstall dependencies after a rebase

After the user rebases or pulls onto an updated base branch (especially when the lockfile or `package.json`/manifest changed), reinstall dependencies (`pnpm i`, `npm i`, `bun i`, `uv sync`, etc.) before trusting typecheck/build/test. Local `node_modules` and generated types lag the new lockfile until you install.

Crucially: when typecheck/build reports errors in files you did **not** touch — particularly right after a rebase or when the base moved — run the install and re-check **first**, before "fixing" the code. Stale dependencies produce confusing type errors that look like real breakage. (Real episode: after a repo bumped react-router, unrelated route test files appeared broken; the cause was stale `node_modules`, and `pnpm i` made it green with zero code changes.)

## Local edge-runtime dev doesn't traverse Cloudflare WARP / Zero Trust

Local edge/worker dev runtimes (MiniOxygen / workerd / wrangler, i.e. Cloudflare Workers and Shopify Hydrogen dev) use their own network + TLS stack — they do **not** go through Cloudflare WARP / Zero Trust on the host machine. So a server-side `fetch` from the dev worker to a host that's only reachable via WARP / a Cloudflare tunnel (e.g. an internal `*.sandbox.*` host) fails with an opaque `internal error; reference = …` and **no HTTP response**, even though `curl` from the shell succeeds (curl rides WARP).

Tell: the host's TLS cert is issued by a `Cloudflare Gateway CA` (WARP is doing TLS inspection). If a worker `fetch` fails this way but `curl` works, suspect WARP — disable WARP, or point the worker at a `localhost`/publicly-reachable host. It is **not** a code/auth bug.

## Non-`awp` worktrees

Manually-created jj worktrees — isolated checkouts driven from another session (e.g. a redwood `awp` session that also has to touch a companion `grove` / `etl-pipelines` checkout) — live under **`~/code/worktrees/<repo>/<slug>/`**, not `~/.awp/workspaces/` (which is `awp`'s own). See that directory's `AGENTS.md` for the layout, the `jj workspace add` recipe, and cleanup rules. Don't scatter ad-hoc `~/code/<repo>-worktrees` dirs.
