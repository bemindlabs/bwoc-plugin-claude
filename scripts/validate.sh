#!/usr/bin/env bash
# validate the Claude Code plugin manifest
set -e
jq . .claude-plugin/plugin.json >/dev/null && echo "plugin.json OK"
jq . .claude-plugin/marketplace.json >/dev/null && echo "marketplace.json OK"
