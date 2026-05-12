---
paths:
  - "tests/**"
  - "**/*.test.*"
  - "**/*.spec.*"
  - "**/test_*.py"
---

# Testing rules (loaded when Claude touches test files)

- Tests mirror the `src/` path: `src/billing/invoice.ts` → `tests/billing/invoice.test.ts`.
- One behaviour per test; the test name states the behaviour ("rejects expired coupon").
- Prefer real objects and in-memory fakes over mocks. Mock only network and clock.
- A bug-fix test must fail on the old code. Commit it before the fix.
- Never weaken or delete an existing assertion to make a test pass. If a test is wrong, say why in the PR.
- Do not add tests for cases that cannot happen; cover the requirements in spec.md and the listed edge cases.
