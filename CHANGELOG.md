# Changelog

All notable changes to the BWOC Claude Code plugin are documented here. The
format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this
project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **CI runs `claude plugin validate .`** with the latest Claude Code CLI, so a manifest the real loader rejects fails the PR instead of the install (as 1.3.0's `"agents": "./agents/"` did).

## [1.3.1] - 2026-09-24

### Fixed

- **The plugin installs on current Claude Code.** `plugin.json` declared `"agents": "./agents/"`, which Claude Code 2.1 rejects (`agents: Invalid input`), so `/plugin install bwoc@bwoc` failed. The field is removed — `agents/` is discovered by default — and the marketplace gains the description the validator asks for. `claude plugin validate .` now passes clean.
- **No stray "README" agent.** `agents/README.md` was loaded by Claude Code as a sub-agent named `README`. It is gone (the main README already covers generating agents with `scripts/build.sh`); `agents/.gitkeep` keeps the directory.

## [1.3.0] - 2026-09-24

### Added

- **`bwoc-loops` skill — Loop-Engineering from Claude Code.** `bwoc monitor` (probe once, alert a fleet agent on an OK↔tripped transition, stable `--id` ledger), `bwoc digest` (deliver at most once per hourly/daily/weekly period, to stdout or `--out`), and `bwoc loop` (the goal-loop control center). The one-shot modes are for Claude to run; `bwoc loop` and every `--loop` run until stopped, so they are handed to the user or a supervisor. `--exec` runs a shell command, so the skill only uses one the user gave or approved.

## [1.2.0] - 2026-09-24

The skills reach the bwoc 3.x verbs they were missing.

### Added

- **`bwoc-lifecycle`: reconfigure in place** — `bwoc set <name> --backend / --primary-model / --fallback-model`, marked mutating, preferred over hand-editing the manifest.
- **`bwoc-messaging`: delivery and triage** — `bwoc receipts` (was the message read, by id / agent / sender), `bwoc outbox` and `outbox flush` (peer delivery queue), and `bwoc triage <agent>` with `--dry-run` as the safe preview; each marked read-only or mutating.
- **`bwoc-health`: version, guide, inventory** — `bwoc update --check` (`--run` flagged as a machine-level change), `bwoc handbook [section]`, `bwoc skill list`, `bwoc plugin list`.

## [1.1.2] - 2026-09-24

Skill commands that work on bwoc 3.x, and a CI check that keeps them working.

### Added

- **CLI contract check.** `scripts/cli-contract.py` runs every `bwoc …` command in commands/skills/agents through the real CLI as `<argv> --help` (the parser rejects an unknown subcommand or flag; nothing executes). CI installs the latest bwoc release for it and runs nightly, so a bwoc release that breaks a documented command shows up here.

### Fixed

- **Three more skill commands match bwoc 3.x.** `bwoc-council`: `council discuss` takes the turn as `--message "<turn>"`, and `okr track` is `<plugin> --key-result <kr> --current <n>` (there is no `--value`). `bwoc-lifecycle`: `bwoc spawn <agent>` does not exist — it takes `--path`/`--backend`; the skill now points at `bwoc chat <agent>`, which resolves both.
- **`bwoc-knowledge` skill uses verbs that exist.** It told Claude to run `bwoc notes add`, `notes show`, `retro add` and `research add`, which bwoc never had (the verbs were `new`/`list`/`view`), and `bwoc doc <kind> …` in the wrong order; on bwoc 3.x the per-kind commands are also deprecated aliases. It now uses `bwoc doc new|list|view <kind>` with the real kind names (`notes`, `retrospectives`, `research`) and documents `memory search --tier 2`.

## [1.1.1] - 2026-07-27

### Changed

- **Docs: seven host adapters.** The README counted the BWOC host adapters without Cursor and Vercel (#5). The plugin manifest kept `1.1.0` in this tag; 1.1.2 brings it back in line.

## [1.1.0] - 2026-06-28

Coordination skills, repo hygiene, and a doc-consistency pass.

### Added

- **Six bundled skills** alongside `bwoc-fleet`, covering the working surface that the
  single coordination skill left uncovered:
  - `bwoc-health` — read-only fleet/workspace diagnostics (`fleet health`, `doctor`,
    `sessions`, `log`, `trust`, `ping`).
  - `bwoc-lifecycle` — agent lifecycle (`new`, `stop`/`start`, `spawn`, `supervise`,
    `debase`, `retire`) framed as uppāda → ṭhiti → vaya.
  - `bwoc-knowledge` — deep-memory plus the dated document kinds (`notes`, `retro`,
    `research`, custom `doc`).
  - `bwoc-quality` — verification gates (`check`, `workspace validate`/`prune`, `audit`).
  - `bwoc-messaging` — inbox read/triage (`inbox`), `send`, and daemon `log`.
  - `bwoc-council` — governed decisions (`council` propose/discuss/vote/resolve) + `okr`.
- **Community-health files** — `CONTRIBUTING.md`, `SECURITY.md`, `CODE_OF_CONDUCT.md`,
  and `.github/` issue + pull-request templates.

### Changed

- `scripts/validate.sh` now also validates **skill** frontmatter (`name` + `description`)
  and, when the `bwoc` CLI is present, advisory-checks that every slash command's wrapped
  verb resolves (`bwoc <verb> --help`).
- `SessionStart` hook hint now advertises `/bwoc:chat` alongside the other commands.

### Fixed

- README no longer labels a shipped release as "beta"; status, badges, and roadmap now
  reflect the stable line.
- Corrected the prior changelog's skill count (the 1.0.0 line shipped **one** committed
  skill, `bwoc-fleet`, not two) and surfaced the `memory` command in the README exposure
  table.

## [1.0.0] - 2026-06-23

First stable release — the BWOC fleet adapter for Claude Code.

### Added

- **8 slash commands** wrapping the `bwoc` CLI for fleet coordination, headless
  task runs, and shared-memory access from inside Claude Code.
- **Local agent re-export** and **1 bundled skill** (`bwoc-fleet`) that surface BWOC
  fleet primitives to the Claude Code host.
- **Hooks** (`hooks/hooks.json`) wiring plugin behavior into Claude Code session
  lifecycle events.
- **Marketplace metadata** (`.claude-plugin/marketplace.json`) so the plugin can
  be added via `/plugin marketplace add bemindlabs/bwoc-plugin-claude` and
  installed with `/plugin install bwoc`.
- **CI quality gate** — `shellcheck` plus a structural smoke test
  (`scripts/validate.sh`) that verifies manifests parse, declared directories
  exist, every command carries frontmatter with a `description:`, hook events and
  types are valid, and the marketplace source resolves.

[1.1.0]: https://github.com/bemindlabs/bwoc-plugin-claude/releases/tag/v1.1.0
[1.0.0]: https://github.com/bemindlabs/bwoc-plugin-claude/releases/tag/v1.0.0
