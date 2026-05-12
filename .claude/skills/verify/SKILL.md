---
name: verify
description: Run the project's checks (lint, typecheck, relevant tests) and report evidence. Use before every commit, before opening a PR, and whenever asked "does it work" or "verify".
allowed-tools: Bash(make lint) Bash(make typecheck) Bash(make test) Bash(make test *) Bash(git diff *) Bash(git status)
---

# Verify the current change

## Changed files
!`git status --short || true`

## Steps
1. `make lint`
2. `make typecheck`
3. Tests for the changed files: `make test FILE=<path>` for each changed source file's test. If shared code changed, run `make test`.
4. If UI files changed and the browser MCP server is available, open the changed screen and compare with the spec.

## Report
- Paste each command and its final result lines.
- State PASS only if every step passed. Otherwise list failures with the root cause.
- Never report success without output to show for it.
