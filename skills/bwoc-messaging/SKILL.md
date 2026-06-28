---
name: bwoc-messaging
description: Read and send messages on a BWOC agent's inbox from Claude Code — inspect an agent's (or the whole fleet's) inbox, count or tail new envelopes, acknowledge/clear a backlog, append a message, and read daemon logs. Use when the user wants to see what work is queued for an agent, triage a backed-up inbox, or hand off a message. Wraps the `bwoc` CLI (shell-out, no server).
---

# BWOC Messaging & Inbox

This skill teaches when and how to work with the BWOC **inbox transport** from Claude Code:
reading what is queued for an agent, sending messages, and triaging a backlog. Every
capability is a thin wrapper over the `bwoc` CLI. Discover exact flags with
`bwoc <verb> --help`, and quote user-supplied values.

## When to use

- "What's queued for agent X?" / "is anyone backed up?" → `bwoc inbox <agent>`, `inbox --all`.
- "How many unread does X have?" → `bwoc inbox <agent> --count`.
- "Send / hand off a message" → `bwoc send`.
- "What did X's daemon say?" → `bwoc log <agent>`.
- "Clear the backlog after I've read it" → `bwoc inbox <agent> --clear` (mutating).

## Reading inboxes (read-only)

```bash
bwoc inbox <agent>             # print one agent's inbox (.bwoc/inbox.jsonl)
bwoc inbox --all               # every agent's inbox, each under a header
bwoc inbox <agent> --limit 20  # only the last N messages
bwoc inbox <agent> --count     # just the envelope count (one integer; pairs with --json)
bwoc inbox <agent> --json      # structured envelopes
bwoc inbox <agent> --watch     # tail mode — block and print new envelopes (Ctrl-C to stop)
```

`--watch` blocks; surface it to the user rather than running it inside the non-interactive
Bash tool. `--all` refuses `--clear`/`--watch`.

## Sending (mutating)

```bash
bwoc send <agent> "<message>"            # append to the agent's inbox; fire-and-forget
bwoc send <agent> "<message>" --from <agent>      # agent → agent sender attribution
bwoc send <agent> --file <FILE>          # send file contents instead of inline text
```

Quote the message so multi-word values stay one argument. Optional: `--reply-to <messageId>`,
`--no-wakeup`.

## Triaging a backlog

```bash
bwoc inbox <agent> --limit 50      # read what piled up first
# ...act on / summarize the messages...
bwoc inbox <agent> --clear         # acknowledge + truncate (asks to confirm)
bwoc inbox <agent> --clear --yes   # required in non-TTY; skips the confirmation
```

## Daemon logs (read-only)

```bash
bwoc log <agent>               # tail the agent's daemon log (.bwoc/agent.log — stderr)
```

## Safety

- `inbox` reads and `log` are read-only. `send` and `inbox --clear` are **mutating** —
  `--clear` is destructive (it deletes messages), so read them first and confirm intent.
- Never `--clear` an inbox you have not actually surfaced to the user.
- Target a specific workspace with `--workspace <path>` (or `BWOC_WORKSPACE`).
