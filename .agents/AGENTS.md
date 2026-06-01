# Agent Instructions

## Answer structure: caveats before highlights

When reporting results, assessments, or reviews, lead with what's wrong, risky, unverified, or limited — before any positive summary. Order:

1. Caveats, failure modes, and anything not tested/verified
2. Open questions or assumptions made
3. Then the highlights / what works

Never open an answer with praise ("Great news!", "This works well") or a success summary. If there are genuinely no caveats, say so explicitly ("No caveats found") rather than skipping straight to the positives.

## Version control

Use [Jujutsu (jj)](https://github.com/jj-vcs/jj) instead of git for version control operations. Most repos here are colocated jj+git workspaces — prefer `jj` commands (`jj st`, `jj log`, `jj diff`, `jj describe`, `jj new`, `jj git push`) over their git equivalents unless the user explicitly asks for git.

## Temporary files

When creating a temporary file or directory, use `mktemp` rather than hardcoding a path under `/tmp`. Capture the path into a variable (`tmp=$(mktemp)` for a file, `dir=$(mktemp -d)` for a directory) and reference it quoted (`"$tmp"`). This avoids collisions between concurrent runs, predictable-path hijacking, and sandbox-write failures; `mktemp` honors `$TMPDIR` by default.

## Reinstall dependencies after a rebase

After the user rebases or pulls onto an updated base branch (especially when the lockfile or `package.json`/manifest changed), reinstall dependencies (`pnpm i`, `npm i`, `bun i`, `uv sync`, etc.) before trusting typecheck/build/test. Local `node_modules` and generated types lag the new lockfile until you install.

Crucially: when typecheck/build reports errors in files you did **not** touch — particularly right after a rebase or when the base moved — run the install and re-check **first**, before "fixing" the code. Stale dependencies produce confusing type errors that look like real breakage. (Real episode: after a repo bumped react-router, unrelated route test files appeared broken; the cause was stale `node_modules`, and `pnpm i` made it green with zero code changes.)

## Local edge-runtime dev doesn't traverse Cloudflare WARP / Zero Trust

Local edge/worker dev runtimes (MiniOxygen / workerd / wrangler, i.e. Cloudflare Workers and Shopify Hydrogen dev) use their own network + TLS stack — they do **not** go through Cloudflare WARP / Zero Trust on the host machine. So a server-side `fetch` from the dev worker to a host that's only reachable via WARP / a Cloudflare tunnel (e.g. an internal `*.sandbox.*` host) fails with an opaque `internal error; reference = …` and **no HTTP response**, even though `curl` from the shell succeeds (curl rides WARP).

Tell: the host's TLS cert is issued by a `Cloudflare Gateway CA` (WARP is doing TLS inspection). If a worker `fetch` fails this way but `curl` works, suspect WARP — disable WARP, or point the worker at a `localhost`/publicly-reachable host. It is **not** a code/auth bug.
