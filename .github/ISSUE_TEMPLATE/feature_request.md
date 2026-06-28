---
name: Feature request
about: Suggest a new command, skill, or improvement to the adapter
title: "[feat] "
labels: enhancement
---

## Problem / motivation

What can't you do today from Claude Code that you'd like to?

## Proposed surface

- [ ] New slash command (`/bwoc:...`)
- [ ] New / updated skill (`skills/<name>/SKILL.md`)
- [ ] Hook or script change
- [ ] Docs

Which `bwoc` subcommand(s) would it wrap?

## Keep-it-thin check

This connector is a thin wrapper over the `bwoc` CLI and ships nothing workspace-specific.

- Does the underlying capability already exist in the `bwoc` CLI? If not, it probably
  belongs in the [BWOC Framework](https://github.com/bemindlabs/BWOC-Framework) first.
- Is the request generic (works for any workspace), not tied to a specific fleet?

## Additional context

Anything else — examples, mockups, links.
