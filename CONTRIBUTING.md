# Contributing to bwoc-plugin-claude

Thanks for helping improve the BWOC → Claude Code adapter. This connector is a **thin
wrapper over the `bwoc` CLI** — logic belongs in the [BWOC
Framework](https://github.com/bemindlabs/BWOC-Framework), not here. Keep contributions in
that spirit.

## Ground rules

- **Stay a thin wrapper.** Commands and skills should shell out to `bwoc` and report its
  output. Do not reimplement framework behavior in the plugin.
- **Stay generic.** This connector ships **no** agents, teams, or workspace identities of
  its own. Anything workspace-specific is *generated locally* and gitignored
  (`/agents/agent-*.md`, `/skills/fw-*/`). Never commit your fleet.
- **No secrets.** Never commit credentials, tokens, or `.bwoc/` contents.

## Before you open a PR

```bash
bash scripts/validate.sh     # structural smoke — must pass
shellcheck -S warning scripts/*.sh
```

`scripts/validate.sh` checks that the manifests parse, declared component dirs exist, every
command **and** skill carries `name`/`description` frontmatter, hook events are valid, and
the marketplace source resolves. CI runs the same gate on every PR.

## Adding a command or skill

- **Commands** live in `commands/<name>.md` with YAML frontmatter (`description:` required;
  `argument-hint` and `allowed-tools: Bash(bwoc:*)` recommended). The body documents the
  wrapped `bwoc` subcommand.
- **Skills** live in `skills/<name>/SKILL.md` with `name:` + `description:` frontmatter.
  Bundled skills are prefixed `bwoc-`; the `fw-*` prefix is reserved for the locally
  generated framework re-exports and is gitignored.
- Keep argument quoting explicit and prefer read-only verbs in examples; mark mutating verbs
  as "confirm first".

## Versioning

Bump `version` in **both** `.claude-plugin/plugin.json` and
`.claude-plugin/marketplace.json` together, and add a `CHANGELOG.md` entry following
[Keep a Changelog](https://keepachangelog.com/) + [SemVer](https://semver.org/).

## Conduct

By participating you agree to the [Code of Conduct](CODE_OF_CONDUCT.md).
