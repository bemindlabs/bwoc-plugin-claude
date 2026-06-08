# Skills

Two kinds of skills live here:

- **`bwoc-*` (committed)** — the coordination surface this connector ships. They wrap the
  `bwoc` CLI and are the same for every workspace (e.g. `bwoc-fleet`).
- **`fw-*` (generated, gitignored)** — BWOC framework skills re-exported from **your**
  workspace. Generate them locally:

  ```bash
  BWOC_WORKSPACE=/path/to/your/workspace bash scripts/sync-skills.sh
  ```

  This emits one `skills/fw-<name>/SKILL.md` per framework skill, each pointing back at
  the canonical `modules/skills/<name>/SPEC.md` in your workspace. These files describe
  YOUR workspace, not this generic connector, so they are gitignored (see `.gitignore`).
