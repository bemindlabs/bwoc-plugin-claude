---
name: bwoc-knowledge
description: Read and write a BWOC workspace's shared knowledge from Claude Code — deep-memory plus the dated document kinds (notes, retrospectives, research, and custom doc kinds). Use when the user wants to recall prior decisions, capture a note or retro after finishing work, file a research doc, or browse what the workspace already knows. Wraps the `bwoc` CLI (shell-out, no server).
---

# BWOC Workspace Knowledge

This skill teaches when and how to use a BWOC workspace's **shared knowledge surface** from
Claude Code: deep-memory (`bwoc memory`) and the dated document kinds (`notes`, `retro`,
`research`, and any custom kind via `bwoc doc`). Everything is a thin wrapper over the
`bwoc` CLI. Discover exact flags with `bwoc <verb> --help`, and quote user-supplied values.

## When to use

- "What did we decide about X?" / "recall prior context" → `bwoc memory search/show`.
- "Note this down" / "capture what we just learned" → `bwoc notes add`.
- "Write a retro for this work" → `bwoc retro add`.
- "File this research / comparison" → `bwoc research add`.
- A custom document kind declared in `.bwoc/doc-kinds.toml` → `bwoc doc <kind> ...`.

## Deep-memory (read-mostly)

```bash
bwoc memory list               # workspace memory entries
bwoc memory show <name>        # read one entry (or --all)
bwoc memory search "<query>"   # case-insensitive substring search
bwoc memory put <name> ...     # write/update an entry (MUTATING — confirm first)
```

Reach for memory when the answer the user needs was likely decided in a past session —
recall before re-deriving.

## Dated documents (notes / retro / research)

Each kind manages `YYYY-MM-DD_<slug>.md` files in its own directory (`notes/`,
`retrospectives/`, `research/`):

```bash
bwoc notes list                       # browse notes
bwoc notes show <file>                # read one note
bwoc notes add "<title>" [...]        # create a dated note (MUTATING)

bwoc retro list | show | add          # retrospectives — same shape
bwoc research list | show | add       # research documents — same shape
```

A common habit: **after finishing a unit of work, capture a retro + a note** so the next
session starts richer.

## Custom document kinds

`notes`/`retro`/`research` are thin aliases over the general `doc` verb. For a kind declared
in `.bwoc/doc-kinds.toml`:

```bash
bwoc doc <kind> list | show <file> | add "<title>"
```

## Safety

- `list`, `show`, `search` are read-only and safe to run anytime.
- `memory put`, `notes/retro/research/doc add` **write files** — confirm intent and quote
  titles/queries so multi-word values stay intact.
- Target a specific workspace with `--workspace <path>` (or `BWOC_WORKSPACE`) when the cwd
  is not inside the intended workspace.
