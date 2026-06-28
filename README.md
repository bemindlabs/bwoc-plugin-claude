<h1 align="center">bwoc-plugin-claude</h1>

<p align="center">
  <strong>BWOC → Claude Code</strong> plugin adapter — bring the BWOC agent fleet into <a href="https://claude.com/claude-code">Claude Code</a>.
</p>

<p align="center">
  <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg">
  <a href="https://bemindlabs.github.io/bwoc-handbook/"><img alt="Handbook" src="https://img.shields.io/badge/docs-BWOC%20Handbook-1f6feb"></a>
  <img alt="Status" src="https://img.shields.io/badge/status-stable-success">
  <img alt="Version" src="https://img.shields.io/badge/version-1.1.0-blue">
  <img alt="Host" src="https://img.shields.io/badge/host-Claude%20Code-d97757">
  <img alt="Part of BWOC" src="https://img.shields.io/badge/part%20of-BWOC-6f42c1">
  <img alt="Mechanism" src="https://img.shields.io/badge/mechanism-wraps%20bwoc%20CLI-informational">
</p>

---

## ✨ Overview

`bwoc-plugin-claude` packages the [**BWOC**](https://github.com/bemindlabs/BWOC-Framework) agent fleet as a **Claude Code plugin**. Once installed, Claude Code can drive your whole BWOC workspace — list agents, send work, run headless tasks, coordinate teams, and read shared memory — without leaving the session.

It is **declarative + shell-out**: the plugin ships slash commands, sub-agents, skills, and hooks that wrap the `bwoc` CLI. No background server, no daemon.

> [!NOTE]
> **Status: stable (v1.1.0).** All components ship and pass the structural smoke
> (`./scripts/validate.sh`): manifests, command **and** skill frontmatter, hook events,
> marketplace source, and CLI presence. The plugin exposes 8 slash commands, seven bundled
> skills (`bwoc-fleet`, `bwoc-health`, `bwoc-lifecycle`, `bwoc-knowledge`, `bwoc-quality`,
> `bwoc-messaging`, `bwoc-council`), the local agent/skill re-export generators, and
> lifecycle hooks. Install it with `/plugin install` in a live Claude Code session.

## 🧩 What it exposes

| Surface | BWOC capability | Wraps |
|---|---|---|
| **Slash commands** | Coordinate the fleet | `bwoc list` · `status` · `send` · `run` · `chat` · `task` · `team` · `memory` |
| **Sub-agents** | Delegate to any agent | generated **locally** from your workspace (not shipped) via `bash scripts/build.sh` |
| **Skills** | Teach the host BWOC workflows | shipped: `bwoc-fleet` · `bwoc-health` · `bwoc-lifecycle` · `bwoc-knowledge` · `bwoc-quality` · `bwoc-messaging` · `bwoc-council` · plus framework `fw-*` skills re-exported locally |
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
- 📚 Reference: the [BWOC Handbook](https://bemindlabs.github.io/bwoc-handbook/)
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
/bwoc:status <agent>         # health + identity snapshot
/bwoc:send <agent> "..."     # append a message to an agent's inbox
/bwoc:run <agent> "..."      # run a single task headless, capture result
/bwoc:team list                  # Saṅgha teams
/bwoc:memory search "..."    # recall workspace deep-memory
@<agent>                     # delegate to a fleet member as a sub-agent
```

The bundled **skills** add deeper, topical guidance the host invokes automatically:
`bwoc-fleet` (coordination), `bwoc-health` (diagnostics), `bwoc-lifecycle` (incarnate /
stop / start / retire), `bwoc-knowledge` (memory + notes / retro / research),
`bwoc-quality` (check / validate / audit gates), `bwoc-messaging` (inbox read + triage +
send), and `bwoc-council` (governed decisions + OKRs).

## 🗂️ Repository layout

```
bwoc-plugin-claude/
├── .claude-plugin/
│   ├── plugin.json          # plugin manifest
│   └── marketplace.json     # single-plugin marketplace
├── commands/                # slash commands wrapping `bwoc`
├── agents/                  # generated locally from your workspace (gitignored)
├── skills/                  # BWOC skills (skills/<name>/SKILL.md)
├── hooks/hooks.json         # lifecycle hooks
└── scripts/                 # validate.sh / build.sh
```

## 🛠️ Development

```bash
bash scripts/validate.sh     # structural smoke (manifests, command + skill frontmatter, hooks)
bash scripts/build.sh        # regenerate the host tree from the live workspace
npx prettier --check .       # lint JSON manifests (markdown is hand-styled; see .prettierignore)
```

## 🗺️ Roadmap

- [x] Scaffold: manifest, marketplace, README, license
- [x] Coordination slash commands (`list/status/send/run/chat/task/team`)
- [x] Agent re-export generator (reads `.bwoc/agents.toml`)
- [x] Deep-memory command
- [x] Skill re-export (generator: scripts/sync-skills.sh)
- [x] Bundled coordination skills (`bwoc-fleet` · `bwoc-health` · `bwoc-lifecycle` · `bwoc-knowledge`)
- [x] Structural smoke test (`scripts/validate.sh` — manifests, command **and** skill frontmatter, hook events, marketplace, CLI presence)
- [x] Community-health files (CONTRIBUTING · SECURITY · CODE_OF_CONDUCT · issue/PR templates)
- [ ] Interactive acceptance: `/plugin install` in a live Claude Code session (human step)

## 🔗 BWOC host-adapter set

One of five BWOC → host adapters, one per agent host:

| Host | Repo |
|---|---|
| **Claude Code** | [bwoc-plugin-claude](https://github.com/bemindlabs/bwoc-plugin-claude) |
| OpenAI Codex | [bwoc-plugin-codex](https://github.com/bemindlabs/bwoc-plugin-codex) |
| Antigravity | [bwoc-plugin-agy](https://github.com/bemindlabs/bwoc-plugin-agy) |
| OpenClaw | [bwoc-plugin-openclaw](https://github.com/bemindlabs/bwoc-plugin-openclaw) |
| Hermes | [bwoc-plugin-hermes](https://github.com/bemindlabs/bwoc-plugin-hermes) |

## 🙏 Maintainer

Maintained by **Bemind Technology**, part of the BWOC host-adapter set. This connector is **generic**: it ships no agents, teams, or workspace identities of its own — it discovers your fleet from the local `bwoc` workspace at runtime.

## 🤝 Contributing

Issues and PRs welcome. Keep the plugin a **thin wrapper over the `bwoc` CLI** — logic belongs in the framework, not here.

## 📄 License

[MIT](LICENSE) © Bemind Technology
