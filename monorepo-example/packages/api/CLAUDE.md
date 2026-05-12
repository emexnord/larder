<!-- Owned by @acme/api-team. Loaded when a session starts here, or when Claude touches a file in this package. -->

# packages/api

- Run commands from this folder: `make test`, `make lint` here run only this package.
- Copy `.env.example` to `.env` before running anything; tests fail without it.
- Database access goes through the query builder in `src/db/`. No raw SQL in route handlers.
- Never edit a merged migration; add a new one.
- Shared types come from `packages/shared`. Change them there, then update every caller in the same PR.
