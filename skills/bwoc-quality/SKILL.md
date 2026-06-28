---
name: bwoc-quality
description: Run a BWOC workspace's verification gates from Claude Code — backend-neutrality audit of agents (bwoc check), workspace structural validation, registry/orphan pruning, and audit-kind plugin findings. Use after editing or adding an agent, before a release, or when the user wants to confirm the workspace is consistent. Read-mostly; wraps the `bwoc` CLI (shell-out, no server).
---

# BWOC Quality & Verification

This skill teaches when and how to run a BWOC workspace's **verification gates** from Claude
Code. These are the checks that keep agents backend-neutral and the workspace internally
consistent. Everything is a thin wrapper over the `bwoc` CLI. Discover exact flags with
`bwoc <verb> --help`.

> **Project rule:** after editing or incarnating **any** agent, run `bwoc check` on it (or
> `bwoc check --all`). Editing an agent's `AGENTS.md` (and its backend symlinks) must stay
> backend-neutral — no YAML frontmatter, no wikilinks, no hardcoded model IDs/vendor names.
> This skill is how you enforce that from the host.

## When to use

- Just edited/added an agent → `bwoc check <agent-path>` (or `--all`).
- "Is the workspace consistent?" → `bwoc workspace validate`.
- "Are there phantom registry entries or orphan agent dirs?" → `bwoc workspace prune`.
- "Run the audit plugins" → `bwoc audit run`.

## Backend-neutrality audit (read-only)

```bash
bwoc check                      # audit the agent in the current directory
bwoc check <agent-path>         # audit a specific agent (e.g. agents/agent-foo)
bwoc check --all                # fleet-wide audit of every incarnated agent
bwoc check --all --json         # structured findings for programmatic gates
```

`check` validates that `AGENTS.md` stays backend-neutral and that `config.manifest.json`
parses and `MEMORY.md` stays within limits. It is read-only and safe to run anytime.

## Workspace validation & pruning

```bash
bwoc workspace info             # resolved path, config, agent count
bwoc workspace validate         # run validation rules (exit 0 ok, 2 on violations)
bwoc workspace prune            # find phantom registry entries / orphan dirs (report-only)
bwoc workspace prune --apply    # fix the safe inconsistencies (MUTATING — confirm first)
```

## Audit-kind plugin findings

```bash
bwoc audit run                  # run every enabled audit-kind plugin; emit canonical findings
```

The exit code equals the number of `fail` findings (clamped to 254); `255` signals a
framework/plugin error. Surface the findings report to the user rather than just the exit
code.

## Safety

- `check`, `workspace info/validate`, `workspace prune` (without `--apply`), and `audit run`
  are read-only/report-only — run them freely.
- `bwoc workspace prune --apply` mutates the workspace — confirm intent first.
- Prefer running `check --all` before a release or after a batch of agent edits.
- Target a specific workspace with `--workspace <path>` (or `BWOC_WORKSPACE`).
