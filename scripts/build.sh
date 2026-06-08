#!/usr/bin/env bash
# build = regenerate the Claude Code host tree from the live BWOC workspace.
#
# Reads the workspace `.bwoc/agents.toml` and emits one Claude Code sub-agent
# file per registered agent into `agents/<id>.md`. Each sub-agent is a thin
# wrapper that delegates to the fleet member via the `bwoc` CLI (run / send).
#
# Workspace resolution: BWOC_WORKSPACE env > default /Users/lps/workspaces/bwoc
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKSPACE="${BWOC_WORKSPACE:-/Users/lps/workspaces/bwoc}"
AGENTS_TOML="$WORKSPACE/.bwoc/agents.toml"
OUT_DIR="$REPO_DIR/agents"

if [[ ! -f "$AGENTS_TOML" ]]; then
  echo "build: agents.toml not found at $AGENTS_TOML" >&2
  echo "build: set BWOC_WORKSPACE to your workspace root and retry." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

# Parse `[[agent]]` tables for `id`, `path`, and `backend` (simple TOML, one
# key per line, double-quoted values). Emitted as `id<TAB>path<TAB>backend`.
parse_agents() {
  awk '
    /^\[\[agent\]\]/ { if (id != "") print id "\t" path "\t" backend; id=""; path=""; backend=""; next }
    /^[[:space:]]*id[[:space:]]*=/      { v=$0; sub(/^[^=]*=[[:space:]]*"/,"",v); sub(/".*$/,"",v); id=v; next }
    /^[[:space:]]*path[[:space:]]*=/    { v=$0; sub(/^[^=]*=[[:space:]]*"/,"",v); sub(/".*$/,"",v); path=v; next }
    /^[[:space:]]*backend[[:space:]]*=/ { v=$0; sub(/^[^=]*=[[:space:]]*"/,"",v); sub(/".*$/,"",v); backend=v; next }
    END { if (id != "") print id "\t" path "\t" backend }
  ' "$AGENTS_TOML"
}

count=0
while IFS=$'\t' read -r id path backend; do
  [[ -z "$id" ]] && continue
  out="$OUT_DIR/$id.md"
  cat > "$out" <<EOF
---
name: $id
description: BWOC fleet member ($id, backend=${backend:-unknown}). Delegate to this incarnated agent — it shells out to the bwoc CLI. Use for work that belongs to $id's specialty inside the BWOC workspace ($path).
tools: Bash
---

You are a thin Claude Code sub-agent that delegates to the BWOC fleet member
**$id** (backend: ${backend:-unknown}, source: \`$path\`). You do no work yourself —
you hand the task to the real agent through the \`bwoc\` CLI and report its result.

To run a single task headless and capture the result:

\`\`\`bash
bwoc run "$id" --task "<the task prompt>"
\`\`\`

To append an async message to this agent's inbox instead:

\`\`\`bash
bwoc send "$id" "<the message>"
\`\`\`

Always quote the task/message so multi-word values stay a single argument. Prefer
\`bwoc run\` when you need the answer back now; use \`bwoc send\` for fire-and-forget
hand-offs. Return the agent's output verbatim.
EOF
  count=$((count + 1))
done < <(parse_agents)

echo "build: generated $count sub-agent file(s) in $OUT_DIR from $AGENTS_TOML"
