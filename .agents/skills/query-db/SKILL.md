---
name: query-db
description: Query databases (Redshift + MySQL) through StrongDM proxies using psql/mysql CLI clients
---

# query-db - Query databases through StrongDM

When the user asks to query Redshift / the analytics warehouse or one of the MySQL databases, connect with the CLI clients (`psql` / `mysql`) through the StrongDM proxy hosts. No credentials are needed — the StrongDM desktop app authenticates the connection.

## Connections

Connection URLs are **not** stored in this skill. Read them at runtime from two machine-local files (both outside any repo):

1. **`~/.local/share/db_ui/connections.json`** — the source of truth (dadbod-ui): a JSON array of `{name, url}`.

   ```bash
   cat ~/.local/share/db_ui/connections.json
   ```

   Pick the connection by name and use its `url` verbatim. Access level is encoded in the host: `-ro` = read-only, `-rw` = read-write. Prefer a `-ro` connection whenever one exists.

2. **`~/.local/share/db_ui/agent-notes.md`** — site-specific hints the URL list can't express: which databases/schemas sit behind each connection, the sandbox-allowlisted host, and which tiers are read-write. Read it if present.

If neither file exists (e.g. a fresh machine), ask the user for the connection URL or to configure their dadbod-ui connections — do not guess hostnames.

## How to query

Non-interactive, one query per invocation. Resolve the URL from `connections.json` first. Do not pass `--user` or `--password` — StrongDM injects auth.

**Redshift (psql)** — `psql` accepts the `postgresql://…` URL directly:

```bash
psql "<postgresql url from connections.json>" -c "select ... limit 100;"
```

Useful flags: `-t` (tuples only), `-A` (unaligned), `--csv` (CSV output), `-v ON_ERROR_STOP=1`.

**MySQL** — the `mysql` client does not take a URL; read `host`/`port`/`db` out of the `mysql://host:port[/db]` URL and pass them as flags:

```bash
mysql --host <host> --port <port> <db> -e "select ... limit 100;"
```

Useful flags: `--batch` (tab-separated, no boxes), `-N` (skip column names). If a MySQL connection has no default database in its URL, pass the target db as the positional arg (as above) or schema-qualify table names, or you'll get "No database selected." See `agent-notes.md` for which db/schema lives behind each connection.

## Rules

- **Default to read-only.** Even on the `-rw` connections, never run INSERT/UPDATE/DELETE/DDL unless the user explicitly asked for a write and named the target. Prefer the `-ro` connection when both exist.
- **Always LIMIT exploratory queries.** Warehouse tables are large; an unbounded `SELECT *` can run for minutes and flood the terminal. Start with `LIMIT 10`–`100` and tight column lists.
- **Discover schema before guessing.** Redshift: `select * from svv_table_info where "table" ilike '%name%';` and `select * from pg_table_def where tablename = '...' and schemaname = '...';` (set `search_path` or filter by schema — `pg_table_def` only shows tables in the search path). MySQL: `show tables;`, `describe <table>;`, `information_schema`.
- **Redshift is not vanilla Postgres.** No `\d` on external tables, different system catalogs (`svv_*`, `stl_*`, `pg_table_def`), no indexes (dist/sort keys instead). Late-binding views may not appear in `pg_views`.
- **One query at a time.** Run a query, read the result, then decide the next one. Don't chain a speculative pipeline of queries in a single command.

## Failure modes

- `could not translate host name ... nodename nor servname provided` — either:
  1. **Agent sandbox** is blocking the host. The allowlisted host is recorded in `~/.claude/settings.json` (`sandbox.network.allowedDomains`) — see `agent-notes.md` for which one; other hosts need a sandbox bypass or an allowlist entry. Retry outside the sandbox before assuming StrongDM is down.
  2. **StrongDM is disconnected.** The StrongDM proxy hosts only resolve while the StrongDM desktop app is connected. There is no `sdm` CLI on this machine — ask the user to check the StrongDM app.
- Connection hangs or auth errors with credentials supplied — remove `--user`/`--password`; StrongDM rejects explicit credentials it didn't issue.

## Exporting results

For CSV handoff, write to a mktemp path:

```bash
out=$(mktemp).csv
psql "<postgresql url from connections.json>" --csv -c "select ...;" > "$out"
echo "$out"
```
