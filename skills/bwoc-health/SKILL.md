---
name: bwoc-health
description: Diagnose the health of a BWOC workspace and its agent fleet from Claude Code. Use when the user wants to check fleet/workspace health, find a stuck or unhealthy agent, see which agents are actually running, read an agent's daemon log, inspect trust profiles, or triage before launching work. Read-only diagnostics that wrap the `bwoc` CLI (shell-out, no server).
---

# BWOC Health & Diagnostics

This skill teaches when and how to **diagnose** a BWOC workspace and its fleet from Claude
Code. Everything here is **read-only** (report-only) and a thin wrapper over the `bwoc`
CLI — there is no server or daemon to manage. Discover exact flags with
`bwoc <verb> --help` if unsure.

## When to use

Reach for diagnostics when the user asks to:

- "Is the fleet healthy?" / "anything broken?" → `bwoc fleet health`, `bwoc doctor`.
- "Which agents are actually running right now?" → `bwoc sessions`.
- "Why is agent X stuck / what did its daemon say?" → `bwoc log <agent>`, `bwoc status <agent>`.
- "Can I trust agent X with this?" → `bwoc trust <agent>`.

Run these **before** delegating heavy work or when something looks wrong — they are always
safe to run.

## Fleet & workspace health (read-only)

```bash
bwoc fleet health              # all 7 Aparihāniya-dhamma governance signals (report-only)
bwoc fleet health --json       # structured signals for programmatic triage
bwoc doctor                    # diagnose environment + workspace problems
bwoc doctor --json             # structured findings
bwoc info                      # one-card system status (version, phase, workspace, agents)
```

`bwoc doctor` can also self-heal safe issues with `--auto` — that is a **mutating** verb,
so treat it as such (confirm intent before running against a live workspace).

## Per-agent diagnostics (read-only)

```bash
bwoc status <agent>            # one agent's health + identity snapshot
bwoc status --all              # full detail for every agent
bwoc sessions                  # running agent sessions (markers + process scan)
bwoc log <agent>               # tail the agent's daemon log (stderr)
bwoc log <agent> --lines 100   # more backlog (check --help for the exact flag)
bwoc trust <agent>             # Kalyāṇamitta-7 trust profile (declared + requiredTrust)
bwoc ping <agent>              # liveness check for a served agent (PING → PONG)
```

## Triage flow

1. Start broad: `bwoc fleet health` + `bwoc doctor` to see workspace-level signals.
2. Narrow: `bwoc status --all` to spot any agent that is `stopped` or has a backed-up inbox.
3. Confirm runtime: `bwoc sessions` shows who is actually executing right now.
4. Root-cause: `bwoc log <agent>` for the daemon's own stderr on a suspect agent.

## Safety

- Every verb here is read-only **except** `bwoc doctor --auto` — confirm before that one.
- Treat a non-empty inbox or `stopped` status as a finding to report, not to silently fix.
- Target a specific workspace with `--workspace <path>` (or `BWOC_WORKSPACE`) when the cwd
  is not inside the intended workspace.
