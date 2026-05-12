---
name: plan-feature
description: Produce work/<change>/plan.md - the ordered implementation plan with files to change, risks, and the tests that prove each step. Use before writing code for any change that touches more than one file.
argument-hint: "[work folder]"
---

# Plan a change

Run this in plan mode (`claude --permission-mode plan`). No code edits until a human approves the plan.

1. Read `$ARGUMENTS/spec.md`. If there is no accepted spec and the change is non-trivial, stop and say so.
2. Delegate exploration to the `planner` subagent: it returns affected files, existing patterns to reuse, and risks.
3. Write `$ARGUMENTS/plan.md` from `docs/templates/plan.md`:
   - ordered steps, each small enough for one commit
   - for each step: files touched, the test that proves it, the command that runs that test
   - a final end-to-end verification step
   - rollback notes for anything touching data or config
4. Map every acceptance criterion in spec.md to at least one step. List any that are not covered.
5. Present the plan and wait for approval. Higher-risk plans (spec marked High) need a tech lead's approval, recorded as a PR review or comment.
