# Changelog

All notable changes to the BWOC Claude Code plugin are documented here. The
format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this
project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
