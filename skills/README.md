# Skills

Two kinds of skills live here:

- **`bwoc-*` (committed)** — the coordination surface this connector ships. They wrap the
  `bwoc` CLI and are the same for every workspace:
  - `bwoc-fleet` — coordinate the fleet (list/status/send/run/team/task/memory overview).
  - `bwoc-health` — read-only diagnostics (fleet health, doctor, sessions, log, trust).
  - `bwoc-lifecycle` — incarnate/stop/start/supervise/retire (uppāda → ṭhiti → vaya).
  - `bwoc-knowledge` — deep-memory plus notes / retro / research / custom doc kinds.
  - `bwoc-quality` — verification gates (check, workspace validate/prune, audit).
  - `bwoc-messaging` — inbox read/triage, send, daemon logs.
  - `bwoc-council` — governed decisions (council propose/vote/resolve) + OKRs.
- **`fw-*` (generated, gitignored)** — BWOC framework skills re-exported from **your**
  workspace. Generate them locally:

  ```bash
  BWOC_WORKSPACE=/path/to/your/workspace bash scripts/sync-skills.sh
  ```

  This emits one `skills/fw-<name>/SKILL.md` per framework skill, each pointing back at
  the canonical `modules/skills/<name>/SPEC.md` in your workspace. These files describe
  YOUR workspace, not this generic connector, so they are gitignored (see `.gitignore`).
