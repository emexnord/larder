---
paths:
  - "src/api/**"
  - "src/handlers/**"
---

# API rules (loaded when Claude touches API code)

- Request and response shapes are defined in the schema files first; handlers follow the schema.
- Errors use the standard error envelope: `{ "error": { "code", "message", "details?" } }`.
- List endpoints are paginated (cursor-based). No unbounded queries.
- Breaking changes need a new version path and a note in spec.md.
- Every handler: validate input → authorize → call service → map result. No business logic in handlers.
