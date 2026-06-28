---
name: Bug report
about: Something in the plugin (a command, skill, hook, or script) misbehaves
title: "[bug] "
labels: bug
---

## What happened

A clear description of the bug.

## Steps to reproduce

1. `/bwoc:...` or `bash scripts/...`
2. ...

## Expected vs actual

- **Expected:**
- **Actual:**

## Environment

- Plugin version (`.claude-plugin/plugin.json` → `version`):
- `bwoc --version`:
- Claude Code version:
- OS:

## `scripts/validate.sh` output

```
paste the output of `bash scripts/validate.sh` here
```

> Reminder: this connector is a thin wrapper over the `bwoc` CLI. If the bug reproduces by
> running the underlying `bwoc <verb>` directly, it likely belongs in the
> [BWOC Framework](https://github.com/bemindlabs/BWOC-Framework) instead.
