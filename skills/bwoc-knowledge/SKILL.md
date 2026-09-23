---
name: bwoc-knowledge
description: Read and write a BWOC workspace's shared knowledge from Claude Code — deep-memory plus the dated document kinds (notes, retrospectives, research, and custom doc kinds). Use when the user wants to recall prior decisions, capture a note or retro after finishing work, file a research doc, or browse what the workspace already knows. Wraps the `bwoc` CLI (shell-out, no server).
---

# BWOC Workspace Knowledge

This skill teaches when and how to use a BWOC workspace's **shared knowledge surface** from
Claude Code: deep-memory (`bwoc memory`) and the dated document kinds (`notes`, `retrospectives`,
`research`, and any custom kind via `bwoc doc`). Everything is a thin wrapper over the
`bwoc` CLI. Discover exact flags with `bwoc <verb> --help`, and quote user-supplied values.

## When to use

- "What did we decide about X?" / "recall prior context" → `bwoc memory search/show`.
- "Note this down" / "capture what we just learned" → `bwoc doc new notes "<title>"`.
- "Write a retro for this work" → `bwoc doc new retrospectives "<title>"`.
- "File this research / comparison" → `bwoc doc new research "<title>"`.
- A custom document kind declared in `.bwoc/doc-kinds.toml` → `bwoc doc <new|list|view> <kind> ...`.

## Deep-memory (read-mostly)

```bash
bwoc memory list               # workspace memory entries
bwoc memory show <name>        # read one entry (or --all)
bwoc memory search "<query>"   # case-insensitive substring search (tier 1)
bwoc memory search "<query>" <agent> --tier 2   # an agent's deep-memory backend
bwoc memory put <name> ...     # write/update an entry (MUTATING — confirm first)
```

Reach for memory when the answer the user needs was likely decided in a past session —
recall before re-deriving.

## Dated documents (notes / retro / research)

Each kind manages `YYYY-MM-DD_<slug>.md` files in its own directory (`notes/`,
`retrospectives/`, `research/`):

```bash
bwoc doc list notes                   # browse notes (newest first)
bwoc doc view notes <date-or-stem>    # read one, e.g. 2026-09-23 or its full stem
bwoc doc new notes "<title>"          # create a dated note (MUTATING)

bwoc doc list|view|new retrospectives ...   # retrospectives — same shape
bwoc doc list|view|new research ...         # research documents — same shape
```

`bwoc notes|retro|research <new|list|view>` still work but are deprecated aliases of
`bwoc doc`; use `doc` so the skill keeps working when they are removed.

A common habit: **after finishing a unit of work, capture a retro + a note** so the next
session starts richer.

## Custom document kinds

The built-in kinds are `notes`, `retrospectives` and `research`. A kind declared in
`.bwoc/doc-kinds.toml` uses the same verbs:

```bash
bwoc doc list <kind> | view <kind> <date-or-stem> | new <kind> "<title>"
```

## Safety

- `list`, `show`, `view`, `search` are read-only and safe to run anytime.
- `memory put` and `doc new` **write files** — confirm intent and quote
  titles/queries so multi-word values stay intact.
- Target a specific workspace with `--workspace <path>` (or `BWOC_WORKSPACE`) when the cwd
  is not inside the intended workspace.
