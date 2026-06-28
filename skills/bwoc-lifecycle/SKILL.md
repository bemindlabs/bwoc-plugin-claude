---
name: bwoc-lifecycle
description: Manage the lifecycle of BWOC agents from Claude Code — incarnate (new), pause/resume (stop/start), supervise the daemon, inspect the base-project binding (debase), and retire. Use when the user wants to add a new agent, pause or reactivate one, keep a daemon alive, or remove an agent from the workspace. Wraps the `bwoc` CLI (shell-out, no server); the mutating verbs follow the workspace's own gates.
---

# BWOC Agent Lifecycle

This skill teaches when and how to drive an agent through its lifecycle —
**uppāda → ṭhiti → vaya** (arise → abide → pass) — from Claude Code. Every capability is a
thin wrapper over the `bwoc` CLI. Discover exact flags with `bwoc <verb> --help`, and quote
user-supplied values.

> Agents are managed by the `bwoc` CLI, never by hand. Do not create, rename, or delete
> agent directories directly — always go through these verbs so the registry
> (`.bwoc/agents.toml`) stays the source of truth.

## When to use

- "Add a new agent" / "incarnate a specialist" → `bwoc new`.
- "Pause this agent" / "bring it back" → `bwoc stop` / `bwoc start`.
- "Keep its daemon alive" → `bwoc supervise`.
- "What project does this agent build against?" → `bwoc debase`.
- "Remove this agent" → `bwoc retire` (confirm first — it edits the registry).

## Read-only first (safe to run anytime)

```bash
bwoc list                      # registered agents (add --status, --running, --json)
bwoc status <agent>            # health + identity snapshot
bwoc debase list               # agent → base-project (worktreeBase) bindings
bwoc debase show <agent>       # one agent's binding detail
```

## Incarnate (uppāda)

```bash
bwoc new <name> [--template <path>] [--target <dir>] [--backend <backend>] [--yes]
```

Creates a new agent from the template and registers it. Honors `--workspace` /
`BWOC_WORKSPACE`. After incarnating, run `bwoc check <agent-path>` to audit backend
neutrality.

## Abide & supervise (ṭhiti)

```bash
bwoc stop <name>               # pause: set status = "stopped" (files kept); --all for the fleet
bwoc start <name>              # reactivate a stopped agent; --all to resume the fleet
bwoc spawn <agent>             # exec the backend CLI in the agent's dir (interactive — surface to the user)
bwoc supervise <agent>        # keep the daemon up: restart on crash, exit cleanly when stopped
```

`bwoc spawn` and `bwoc supervise` exec/attach to long-running processes — surface them to
the user rather than running them blind inside the non-interactive Bash tool.

## Retire (vaya)

```bash
bwoc retire <name>             # remove the agent from the registry + files
```

This is destructive and outward-facing on the fleet — **always confirm intent** before
firing it, and report exactly what was removed.

## Safety

- `new`, `stop`, `start`, `retire`, `debase set`, `supervise` are **mutating** — confirm
  before running them against a live workspace.
- Never hand-edit agent directories; let these verbs keep `.bwoc/agents.toml` authoritative.
- After any incarnation or edit, run `bwoc check <agent-path>` (or `bwoc check --all`).
- Target a specific workspace with `--workspace <path>` (or `BWOC_WORKSPACE`).
