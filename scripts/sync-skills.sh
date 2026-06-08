#!/usr/bin/env bash
# sync-skills = re-export the live BWOC workspace's framework skills as Claude
# Code skills.
#
# For each skill in `bwoc skill list --json`, fetch `bwoc skill show <name>
# --json` and emit `skills/fw-<name>/SKILL.md` — a lean Claude Code skill file
# that points back at the canonical SPEC in YOUR workspace. The plugin ships no
# skill content of its own: the generated `skills/fw-*` files are gitignored.
#
# Workspace resolution: BWOC_WORKSPACE env (required — no default path).
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKSPACE="${BWOC_WORKSPACE:-}"
if [[ -z "$WORKSPACE" ]]; then
  echo "sync-skills: set BWOC_WORKSPACE to your BWOC workspace root." >&2
  exit 2
fi
command -v jq >/dev/null 2>&1 || { echo "sync-skills: jq is required." >&2; exit 1; }
command -v bwoc >/dev/null 2>&1 || { echo "sync-skills: bwoc CLI not on PATH." >&2; exit 1; }

SKILLS_DIR="$REPO_DIR/skills"
mkdir -p "$SKILLS_DIR"

# List skill names from the workspace (empty list is valid — emit nothing).
names="$(bwoc skill list --workspace "$WORKSPACE" --json | jq -r '.skills[].name')"

count=0
while IFS= read -r name; do
  [[ -z "$name" ]] && continue
  detail="$(bwoc skill show "$name" --workspace "$WORKSPACE" --json)"

  desc="$(jq -r '.skill.description // ""' <<<"$detail")"
  # Render the exposes contract as a comma-separated list, or empty.
  exposes="$(jq -r '(.skill.exposes // []) | join(", ")' <<<"$detail")"

  out_dir="$SKILLS_DIR/fw-$name"
  mkdir -p "$out_dir"
  {
    printf -- '---\n'
    printf 'name: bwoc-fw-%s\n' "$name"
    printf 'description: %s\n' "$desc"
    printf -- '---\n\n'
    printf '# BWOC framework skill: `%s`\n\n' "$name"
    printf 'This re-exports the BWOC framework skill `%s` into Claude Code.\n\n' "$name"
    printf '**Purpose:** %s\n\n' "$desc"
    printf 'The full spec lives at `modules/skills/%s/SPEC.md` in your active BWOC workspace — read it there for the authoritative contract and procedures.\n' "$name"
    if [[ -n "$exposes" ]]; then
      printf '\n**Exposes:** %s\n' "$exposes"
    fi
  } > "$out_dir/SKILL.md"
  count=$((count + 1))
done <<<"$names"

echo "sync-skills: re-exported $count framework skill(s) into $SKILLS_DIR/fw-*"
