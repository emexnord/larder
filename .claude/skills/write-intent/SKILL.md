---
name: write-intent
description: Turn a feature idea, bug report or request into work/<change>/intent.md. Use when a product owner, designer or engineer starts a new piece of work, or says "new feature", "new request", "write the intent".
argument-hint: "[short-name] [one-line idea]"
---

# Write intent.md

Goal: a one-page proto-spec a product owner can accept or reject. No solution design yet.

1. Ask scoping questions with the AskUserQuestion tool until you can fill every section of
   `docs/templates/intent.md`. Ask about the hard parts: who is affected, what must not change, how success is measured.
   Do not ask what the codebase can answer; look it up instead.
2. If an issue tracker MCP server is connected and the user named a ticket, read it first.
3. Create `work/$(date +%Y-%m)-<short-name>/intent.md` from the template. Keep it under one page.
4. List open questions explicitly. Do not invent answers.
5. Commit on a branch `intent/<yyyy-mm>-<short-name>` and open a PR titled `intent: <short-name>`.
   The product owner's merge of that PR is the acceptance record.
