# Agent Instructions Layout

This repository uses `.agents/` as the canonical home for agent instructions and skills.

## Canonical files

- `.agents/AGENTS.md`
- `.agents/skills/*/SKILL.md`

## Compatibility targets (generated/synced)

These paths exist for tool compatibility and should be kept in sync from `.agents/`:

- `AGENTS.md`
- `.github/copilot-instructions.md`
- `.pi/agent/skills/*/SKILL.md`
- `agent_skills/*/SKILL.md`
- `.omp/commands/*.md`
- `~/.claude/CLAUDE.md` (symlink)
- `~/.claude/commands/*.md` (symlinks)

## Sync

Run:

```bash
./scripts/sync-agents.sh
```

This copies canonical docs/skills from `.agents/` into compatibility paths.
