# Generated sub-agents (not shipped)

This connector is **generic** — it ships **no** agents. Sub-agent files are generated
**locally** from *your* BWOC workspace and are gitignored (`/agents/agent-*.md`).

Generate them for your own fleet:

```bash
BWOC_WORKSPACE=/path/to/your/bwoc/workspace bash scripts/build.sh
```

This reads `$BWOC_WORKSPACE/.bwoc/agents.toml` and writes one Claude Code sub-agent
(`agents/<id>.md`) per registered agent — each a thin delegator that shells out to
`bwoc run` / `bwoc send`. Nothing about your fleet is committed to this repo.
