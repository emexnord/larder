---
name: write-spec
description: Write work/<change>/spec.md from an accepted intent.md - behaviour, interfaces, edge cases, acceptance criteria and flagged risks. Use after an intent is merged, or when asked to "spec this".
argument-hint: "[work folder]"
---

# Write spec.md

Input: `$ARGUMENTS/intent.md` (accepted). Output: `$ARGUMENTS/spec.md` from `docs/templates/spec.md`.

1. Read intent.md, `docs/ai/architecture.md` and the code areas it touches. Use the Explore subagent for wide reading so the main context stays small.
2. Write behaviour as testable acceptance criteria (Given / When / Then). Every criterion must be checkable by a test or a QA step.
3. Name the files, modules and interfaces involved, and what is explicitly out of scope.
4. Flag risks under "Concerns for review": security, privacy, data migration, performance, breaking API changes. Mark each Low / Medium / High.
5. Hand the draft to the `spec-auditor` subagent. Fix gaps it reports that affect correctness or scope; ignore style remarks.
6. Commit and open a PR `spec: <short-name>`. High-risk concerns need a tech lead reviewer on that PR.
