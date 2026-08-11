# Stale dependencies after a rebase

Reinstall dependencies (`pnpm i`, `npm i`, `bun i`, `uv sync`) after a rebase or pull onto an updated base — especially when the lockfile or manifest changed — before trusting typecheck, build or test. Local `node_modules` and generated types lag the new lockfile.

Tell: typecheck or build errors in files you did not touch, right after a base move.

Install and re-check before editing code, not after.
