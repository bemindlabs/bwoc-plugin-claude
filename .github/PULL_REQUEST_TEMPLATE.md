## What & why

Briefly: what does this change, and why?

## Type

- [ ] New / updated command
- [ ] New / updated skill
- [ ] Hook or script
- [ ] Docs / community-health
- [ ] CI / tooling

## Checklist

- [ ] `bash scripts/validate.sh` passes
- [ ] `shellcheck -S warning scripts/*.sh` clean (if scripts changed)
- [ ] Stays a **thin wrapper** over the `bwoc` CLI — no framework logic reimplemented here
- [ ] Stays **generic** — no agents, teams, secrets, or workspace-specific files committed
- [ ] `version` bumped in **both** `plugin.json` and `marketplace.json` (if releasing)
- [ ] `CHANGELOG.md` updated

## Notes for reviewers

Anything non-obvious, trade-offs, or follow-ups.
