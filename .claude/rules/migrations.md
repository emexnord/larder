---
paths:
  - "**/migrations/**"
---

# Database migration rules

- Never edit a migration that has merged. Add a new one.
- Migrations are additive and backward compatible with the currently deployed code (expand, then contract in a later release).
- Every migration has a tested down/rollback step.
- Large table changes run in batches; mention expected run time in plan.md.
