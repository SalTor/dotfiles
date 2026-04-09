#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

mkdir -p .github .pi/agent/skills agent_skills .omp/commands
mkdir -p "$HOME/.claude/commands"

# Canonical AGENTS.md -> compatibility locations
cp .agents/AGENTS.md AGENTS.md

cat > .github/copilot-instructions.md <<'EOF'
# GitHub Copilot Instructions

Canonical agent instructions live in:

- `.agents/AGENTS.md`
- `.agents/skills/*/SKILL.md`

This file is maintained by `scripts/sync-agents.sh`.

## Core workflow reminders

- Use `bd` (beads) for issue tracking in this repo.
- Use `--json` for programmatic `bd` usage.
- Keep issue state in sync with code changes.

For full details, see `../.agents/AGENTS.md`.
EOF

# Canonical skills -> compatibility directories
for skill_dir in .agents/skills/*; do
  [ -d "$skill_dir" ] || continue
  skill_name="$(basename "$skill_dir")"

  mkdir -p ".pi/agent/skills/$skill_name" "agent_skills/$skill_name"
  cp "$skill_dir/SKILL.md" ".pi/agent/skills/$skill_name/SKILL.md"
  cp "$skill_dir/SKILL.md" "agent_skills/$skill_name/SKILL.md"
  cp "$skill_dir/SKILL.md" ".omp/commands/$skill_name.md"
  ln -sfn "$repo_root/$skill_dir/SKILL.md" "$HOME/.claude/commands/$skill_name.md"
done

# Claude Code global instructions
ln -sfn "$repo_root/.agents/AGENTS.md" "$HOME/.claude/CLAUDE.md"

echo "Synced agent instructions from .agents/"
