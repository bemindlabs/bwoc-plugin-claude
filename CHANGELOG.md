# Changelog

All notable changes to the BWOC Claude Code plugin are documented here. The
format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this
project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-06-23

First stable release — the BWOC fleet adapter for Claude Code.

### Added

- **8 slash commands** wrapping the `bwoc` CLI for fleet coordination, headless
  task runs, and shared-memory access from inside Claude Code.
- **1 bundled agent** and **2 skills** that surface BWOC fleet primitives to the
  Claude Code host.
- **Hooks** (`hooks/hooks.json`) wiring plugin behavior into Claude Code session
  lifecycle events.
- **Marketplace metadata** (`.claude-plugin/marketplace.json`) so the plugin can
  be added via `/plugin marketplace add bemindlabs/bwoc-plugin-claude` and
  installed with `/plugin install bwoc`.
- **CI quality gate** — `shellcheck` plus a structural smoke test
  (`scripts/validate.sh`) that verifies manifests parse, declared directories
  exist, every command carries frontmatter with a `description:`, hook events and
  types are valid, and the marketplace source resolves.

[1.0.0]: https://github.com/bemindlabs/bwoc-plugin-claude/releases/tag/v1.0.0
