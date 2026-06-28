---
name: bwoc-council
description: Run formal multi-agent decisions and objective tracking on a BWOC workspace from Claude Code — open a council decision (propose), discuss, vote, and resolve by the plugin's voting model + quorum, plus list/track/report OKR key results. Use when a team needs a governed decision recorded (not just a chat) or wants to track objectives. Wraps the `bwoc` CLI; the live paths need a council/okr-kind plugin installed.
---

# BWOC Council & OKRs

This skill teaches when and how to drive **governed coordination** on a BWOC workspace from
Claude Code: formal decisions (`council`) and objective/key-result tracking (`okr`). Both
are framework *plugin kinds* — the live behavior comes from an installed plugin, and the
verbs are thin wrappers over the `bwoc` CLI. Discover exact flags with `bwoc <verb> --help`.

> These dispatch to a named plugin (e.g. `council-sangha-7` for voting/quorum, or
> `workspace-okrs` for objectives). If none is installed, the live verbs exit `4` with an
> install hint — report that to the user rather than treating it as a failure of this skill.

## When to use

- A team needs a **recorded** decision (question + options + a vote), not just a chat →
  `bwoc council`.
- "What did we decide, and who dissented?" → `bwoc council list/show`.
- Track or report on objectives / key results → `bwoc okr`.

## Council — a governed decision (uses a team)

```bash
bwoc council propose "<question>" --options "a,b,c" --team <team>   # open a decision
bwoc council discuss <decision> --as <agent> "<turn>"   # add a round turn (routes via inbox)
bwoc council vote <decision> --as <agent> --option <opt>   # cast/re-cast a vote (append-only)
bwoc council vote <decision> --as <agent> --abstain        # abstain
bwoc council resolve <decision>     # tally per the voting model, check quorum, record outcome
bwoc council list                   # decisions recorded in this workspace
bwoc council show <decision>        # one decision's full Council Decision Schema entry
```

Participants are drawn from a `bwoc team`; the voting model + quorum come from the
council-kind plugin's manifest. Every verb has a `--json` twin. Confirm exact flag names
with `bwoc council <verb> --help` — they are plugin-driven.

## OKRs — objectives & key results

```bash
bwoc okr list                   # installed okr-kind plugins (enabled + disabled)
bwoc okr show <plugin>          # a plugin's SPEC + objectives summary
bwoc okr track <kr> --value <n> # record a key result's current value (writes local TOML)
bwoc okr report                 # OKR Progress Schema JSON for every key result
```

`okr track` writes the operator's own `key_results.toml` (a local-file write — no
confirmation gate), but still surface what you recorded.

## Safety

- `list`, `show`, `report` are read-only. `propose`, `discuss`, `vote`, `resolve`, and
  `okr track` **record state** — confirm intent and quote free-text (questions, turns).
- A `propose`/`discuss`/`vote`/`resolve` flow is append-only and auditable; do not try to
  rewrite a recorded decision — open a new one.
- A missing plugin exits `4` — relay the install hint instead of retrying blindly.
- Target a specific workspace with `--workspace <path>` (or `BWOC_WORKSPACE`).
