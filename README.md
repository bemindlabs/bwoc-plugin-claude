# bwoc-plugin-claude

> **BWOC → Claude Code plugin adapter.** Exposes the BWOC agent fleet — coordination CLI, agents-as-subagents, skills, and deep-memory — into **Claude Code** by wrapping the `bwoc` CLI.

**Status:** 🚧 WIP scaffold.
Part of the BWOC **八仙過海・各顯神通** host-adapter set (Eight Immortals crossing the sea — each adapter crosses into a foreign host by its own plugin format).

**Steward:** `agent-ludongbin` (Lü Dongbin 呂洞賓) — debased to this project ([`bwoc debase`](https://github.com/bemindlabs/BWOC-Framework)).

## What it exposes

| Surface | Wraps |
|---|---|
| Coordination | `bwoc list / status / send / run / chat / task / team` |
| Agents | BWOC `agents/agent-*` re-exported as Claude Code sub-agents |
| Skills | BWOC skills re-exported as Claude Code skills |
| Deep-memory | `bwoc memory` bridge |

Mechanism: **shell-out to the `bwoc` CLI** — no standing server. The host must have `bwoc` on `PATH`.

## Manifest

Host plugin manifest: `.claude-plugin/plugin.json`

## License

MIT © Bemind Technology
