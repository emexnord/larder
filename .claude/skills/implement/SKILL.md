---
name: implement
description: Implement an approved plan.md step by step with tests and verification after each step. Use when the user says "implement the plan", "build it", or "fix this bug" and an approved plan or failing test exists.
argument-hint: "[work folder] [bugfix]"
---

# Implement an approved plan

1. Read `$ARGUMENTS/plan.md`. Confirm it is approved (merged, or approval noted in the PR). If not, stop.
2. Work on a branch named after the work folder. For parallel work use a worktree (`claude --worktree`).
3. **Bug fix mode** (if the second argument is `bugfix`):
   - write a test that reproduces the bug and fails; run it and show the failure
   - commit it alone: `test: reproduce <bug>`
   - run `mkdir -p .claude/state && touch .claude/state/freeze-tests` so tests cannot be changed during the fix
4. For each plan step, in order:
   - make the change
   - run the step's test command and paste the output
   - commit with `<area>: <summary>` once green
   - if the code must depart from the plan, update plan.md in the same commit and say why
5. After the last step run `/verify`. Fix failures at the root cause; never skip, mute or loosen a test.
6. In bug fix mode run `rm -f .claude/state/freeze-tests` at the end.
7. Ask the `code-reviewer` subagent to review the full diff against spec.md and plan.md. Fix Critical and Major findings, then re-run `/verify`.
8. Report: steps done, evidence (command + result), anything left open.
