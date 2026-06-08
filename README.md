<h1 align="center">bwoc-plugin-claude</h1>

<p align="center">
  <strong>BWOC → Claude Code</strong> plugin adapter — bring the BWOC agent fleet into <a href="https://claude.com/claude-code">Claude Code</a>.
</p>

<p align="center">
  <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg">
  <img alt="Status" src="https://img.shields.io/badge/status-WIP-orange">
  <img alt="Host" src="https://img.shields.io/badge/host-Claude%20Code-d97757">
  <img alt="Part of BWOC" src="https://img.shields.io/badge/part%20of-BWOC%20%E5%85%AB%E4%BB%99-6f42c1">
  <img alt="Mechanism" src="https://img.shields.io/badge/mechanism-wraps%20bwoc%20CLI-informational">
</p>

---

## ✨ Overview

`bwoc-plugin-claude` packages the [**BWOC**](https://github.com/bemindlabs/BWOC-Framework) agent fleet as a **Claude Code plugin**. Once installed, Claude Code can drive your whole BWOC workspace — list agents, send work, run headless tasks, coordinate teams, and read shared memory — without leaving the session.

It is **declarative + shell-out**: the plugin ships slash commands, sub-agents, skills, and hooks that wrap the `bwoc` CLI. No background server, no daemon.

> [!NOTE]
> **Status: WIP.** Manifest and layout are in place; command/agent/skill bodies are landing incrementally. See the [roadmap](#️-roadmap).

## 🧩 What it exposes

| Surface | BWOC capability | Wraps |
|---|---|---|
| **Slash commands** | Coordinate the fleet | `bwoc list` · `status` · `send` · `run` · `chat` · `task` · `team` |
| **Sub-agents** | Delegate to fleet members | `agents/agent-*` re-exported as Claude Code sub-agents |
| **Skills** | Reuse BWOC skills | BWOC skills re-exported as `skills/<name>/SKILL.md` |
| **Memory** | Shared deep-memory | `bwoc memory` bridge |

## 🏗️ How it works

```
Claude Code  ──/bwoc:send──▶  plugin command  ──exec──▶  bwoc CLI  ──▶  BWOC workspace
                                                                        (agents, teams,
                                                                         tasks, memory)
```

Every surface is a thin wrapper over a `bwoc` subcommand, so the plugin inherits the workspace's own permission and verification gates.

## 📋 Prerequisites

- [Claude Code](https://claude.com/claude-code)
- The [`bwoc` CLI](https://github.com/bemindlabs/BWOC-Framework) installed and on `PATH`
- A BWOC workspace (`bwoc init`) reachable from where Claude Code runs

## 📦 Installation

```bash
# inside Claude Code
/plugin marketplace add bemindlabs/bwoc-plugin-claude
/plugin install bwoc@bwoc
```

Or clone it and point a local marketplace at the checkout:

```bash
git clone https://github.com/bemindlabs/bwoc-plugin-claude
```

## 🚀 Usage

```text
/bwoc:list                       # list registered agents
/bwoc:status agent-luban         # health + identity snapshot
/bwoc:send agent-luban "..."     # append a message to an agent's inbox
/bwoc:run agent-luban "..."      # run a single task headless, capture result
/bwoc:team list                  # Saṅgha teams
@agent-luban                     # delegate to a fleet member as a sub-agent
```

## 🗂️ Repository layout

```
bwoc-plugin-claude/
├── .claude-plugin/
│   ├── plugin.json          # plugin manifest
│   └── marketplace.json     # single-plugin marketplace
├── commands/                # slash commands wrapping `bwoc`
├── agents/                  # BWOC agents re-exported as sub-agents
├── skills/                  # BWOC skills (skills/<name>/SKILL.md)
├── hooks/hooks.json         # lifecycle hooks
└── scripts/                 # validate.sh / build.sh
```

## 🛠️ Development

```bash
bash scripts/validate.sh     # validate plugin.json / marketplace.json
bash scripts/build.sh        # regenerate the host tree from the live workspace
prettier --check .           # lint
```

## 🗺️ Roadmap

- [x] Scaffold: manifest, marketplace, README, license
- [ ] Coordination slash commands (`list/status/send/run/chat/task/team`)
- [ ] Agent re-export generator (reads `.bwoc/agents.toml`)
- [ ] Skill re-export
- [ ] Deep-memory command
- [ ] Smoke test inside Claude Code

## 🌊 The Eight Immortals host-adapter set

One of five BWOC → host adapters — **八仙過海・各顯神通** (the Eight Immortals cross the sea, each by their own power):

| Host | Repo | Steward |
|---|---|---|
| **Claude Code** | [bwoc-plugin-claude](https://github.com/bemindlabs/bwoc-plugin-claude) | 呂洞賓 Lü Dongbin |
| OpenAI Codex | [bwoc-plugin-codex](https://github.com/bemindlabs/bwoc-plugin-codex) | 曹國舅 Cao Guojiu |
| Antigravity | [bwoc-plugin-agy](https://github.com/bemindlabs/bwoc-plugin-agy) | 張果老 Zhang Guolao |
| OpenClaw | [bwoc-plugin-openclaw](https://github.com/bemindlabs/bwoc-plugin-openclaw) | 鐵拐李 Li Tieguai |
| Hermes | [bwoc-plugin-hermes](https://github.com/bemindlabs/bwoc-plugin-hermes) | 漢鍾離 Han Zhongli |

## 🙏 Steward

Maintained by **`agent-ludongbin`** (呂洞賓 Lü Dongbin) — leader of the Eight Immortals, sword in hand. The flagship adapter for the flagship host.

## 🤝 Contributing

Issues and PRs welcome. Keep the plugin a **thin wrapper over the `bwoc` CLI** — logic belongs in the framework, not here.

## 📄 License

[MIT](LICENSE) © Bemind Technology
