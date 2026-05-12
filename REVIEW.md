# Code review guidelines

Used by the managed Claude Code Review service and by the review skills/agents in this repo.
General coding rules live in CLAUDE.md; this file holds review-only rules.

## Severity
- **Critical**: security hole, data loss, broken migration, auth bypass, secret in code. Must fix before merge.
- **Major**: wrong behaviour versus spec.md, missing test for a stated requirement, unhandled error path, breaking API change without a version bump.
- **Minor**: maintainability problems likely to cause bugs later.
- **Nit**: style. Report at most 3 nits per PR.

## Always check
- The change matches `work/<change>/spec.md` and `plan.md`; nothing outside the stated scope changed.
- Every new branch of logic has a test; bug fixes include a test that failed before the fix.
- Input validation and authorization on every new endpoint or handler.
- Database migrations are additive and reversible; no edits to merged migrations.
- No secrets, tokens, personal data or debug logging of request bodies.
- Public API, config or CLAUDE.md statements that this change makes outdated.

## Skip
- `**/generated/**`, lock files, snapshots under `**/__snapshots__/**`

## Output
- Inline comments on the exact line, with severity and a concrete fix.
- If nothing Critical or Major is found, say so in one line. Do not pad with nits.
- Findings never approve a PR. A human code owner approves.
