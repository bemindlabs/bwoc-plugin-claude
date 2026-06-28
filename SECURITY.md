# Security Policy

## Scope

`bwoc-plugin-claude` is a **declarative + shell-out** adapter: it ships slash commands,
skills, and hooks that exec the local `bwoc` CLI. It runs no server and opens no network
listener. Its security posture is therefore mostly about **what it shells out to** and
**what it might commit**.

The most relevant risks for this repo:

- **Command injection** via unquoted user input flowing into a shell-out.
- **Secret/identity leakage** — committing `.bwoc/` contents, tokens, or a real fleet
  (`agents/agent-*.md`, `skills/fw-*/`) that should stay local and gitignored.
- **Over-broad hooks** that run on session lifecycle events.

Vulnerabilities in the `bwoc` CLI itself belong to the
[BWOC Framework](https://github.com/bemindlabs/BWOC-Framework); report those there.

## Reporting a vulnerability

Please **do not** open a public issue for a security problem.

- Use **GitHub → Security → Report a vulnerability** (private advisory) on this repo, or
- email **security@bemind.tech** with steps to reproduce and impact.

We aim to acknowledge within a few business days and will coordinate a fix and disclosure
timeline with you.

## Supported versions

The latest released minor line receives security fixes. Older lines are best-effort.
