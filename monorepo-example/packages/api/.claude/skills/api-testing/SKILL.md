---
name: api-testing
description: Testing patterns for the API package. Use when writing or modifying tests in packages/api/.
---

## Structure
Tests are in `src/__tests__/`, mirroring `src/`. Each route file has a matching `.test.ts`.

## Run
- All: `make test`
- One file: `make test FILE=src/__tests__/routes/users.test.ts`

## Helpers
- `src/__tests__/helpers/db.ts`: `setupTestDb()` / `teardownTestDb()`
- `src/__tests__/helpers/auth.ts`: `createTestUser()` / `getAuthToken()`

## Patterns
- HTTP assertions with `supertest`, not raw fetch
- Wrap database tests in a transaction that rolls back
- Mock external services only in `src/__tests__/mocks/`
