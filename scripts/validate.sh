#!/usr/bin/env bash
# validate.sh — structural smoke test for the BWOC Claude Code plugin.
#
# Checks everything that can be verified without a live Claude Code session:
# manifests parse, declared component dirs exist, every command has the required
# frontmatter, hook events are valid + well-formed, the marketplace source
# resolves, and (advisory) the `bwoc` CLI the commands wrap is on PATH.
#
# Exit 0 = the plugin is structurally sound and ready to load. Exit 1 = a problem
# Claude Code would reject. The one thing this can't do is drive the live host —
# that's the human's final `/plugin install` acceptance.

set -uo pipefail
cd "$(dirname "$0")/.." || exit 1

fail=0
ok()   { printf '  ok    %s\n' "$1"; }
bad()  { printf '  FAIL  %s\n' "$1"; fail=1; }
warn() { printf '  warn  %s\n' "$1"; }

echo "BWOC Claude Code plugin — structural smoke"
echo

# 1. Manifests parse.
for f in .claude-plugin/plugin.json .claude-plugin/marketplace.json hooks/hooks.json; do
  if jq -e . "$f" >/dev/null 2>&1; then ok "$f parses"; else bad "$f is not valid JSON"; fi
done

# 2. Declared component paths in plugin.json exist.
for key in commands agents skills; do
  p=$(jq -r --arg k "$key" '.[$k] // empty' .claude-plugin/plugin.json)
  [ -z "$p" ] && continue
  if [ -d "$p" ]; then ok "plugin.$key → $p exists"; else bad "plugin.$key → $p missing"; fi
done
hooks_path=$(jq -r '.hooks // empty' .claude-plugin/plugin.json)
if [ -n "$hooks_path" ]; then
  if [ -f "$hooks_path" ]; then ok "plugin.hooks → $hooks_path exists"; else bad "plugin.hooks → $hooks_path missing"; fi
fi

# 3. Every command has frontmatter with a description.
shopt -s nullglob
cmds=(commands/*.md)
if [ ${#cmds[@]} -eq 0 ]; then
  bad "no command files under commands/"
else
  for c in "${cmds[@]}"; do
    if [ "$(head -1 "$c")" != "---" ]; then bad "$c: missing frontmatter (--- on line 1)"; continue; fi
    if awk '/^---$/{n++; next} n==1 && /^description:/{found=1} END{exit !found}' "$c"; then
      ok "$(basename "$c") frontmatter + description"
    else
      bad "$c: frontmatter has no 'description:'"
    fi
  done
fi

# 4. Hook events are known + entries are well-formed.
known='SessionStart SessionEnd PreToolUse PostToolUse UserPromptSubmit Stop SubagentStop Notification PreCompact'
for ev in $(jq -r '.hooks | keys[]' hooks/hooks.json 2>/dev/null); do
  if echo " $known " | grep -q " $ev "; then ok "hook event $ev is valid"; else bad "hook event '$ev' is not a Claude Code hook event"; fi
done
# Every leaf hook needs type + command.
if jq -e '[.hooks[][].hooks[] | select((.type|not) or (.command|not))] | length == 0' hooks/hooks.json >/dev/null 2>&1; then
  ok "every hook entry has type + command"
else
  bad "a hook entry is missing 'type' or 'command'"
fi

# 5. Marketplace source resolves.
for src in $(jq -r '.plugins[].source' .claude-plugin/marketplace.json 2>/dev/null); do
  if [ -e "$src" ] || [ "$src" = "./" ]; then ok "marketplace source $src resolves"; else bad "marketplace source $src does not exist"; fi
done

# 6. Advisory: the wrapped CLI is present (the plugin still installs without it;
#    the SessionStart hook degrades gracefully, but commands need it at runtime).
if command -v bwoc >/dev/null 2>&1; then
  ok "bwoc CLI on PATH ($(bwoc list --count 2>/dev/null || echo '?') agents in cwd workspace)"
else
  warn "bwoc CLI not on PATH — commands need it at runtime (the SessionStart hook says so too)"
fi

echo
if [ "$fail" -eq 0 ]; then
  echo "PASS — plugin is structurally sound. Final step: \`/plugin marketplace add\` + \`/plugin install\` in Claude Code."
else
  echo "FAIL — fix the items above before loading in Claude Code."
fi
exit "$fail"
