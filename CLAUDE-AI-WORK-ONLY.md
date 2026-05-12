<!--
  Root project instructions. Loaded in EVERY session for EVERY role, so keep it under ~200 lines.
  Rule for adding a line: "Would removing this cause Claude to make a mistake?" If not, cut it.
  Long reference material goes to docs/ai/ (linked, not @-imported) or into a skill.
  Area-specific rules go to .claude/rules/ with `paths:` frontmatter.
  HTML comments like this one are stripped before Claude sees the file.
  Owner: see .github/CODEOWNERS
-->

# <Project name>

<One or two sentences: what this system does and who uses it.>

## Commands
- Install: `make setup`
- Run locally: `make dev`
- Unit tests (single file): `make test FILE=<path>` — prefer this over the full suite
- Full tests: `make test`
- Lint + format: `make lint`
- Type check: `make typecheck`
- E2E: `make e2e` (needs `make dev` running)

Always run lint, typecheck and the relevant tests before saying a task is done, and paste the output.

## Layout
- `src/` application code, `tests/` tests mirror `src/`
- `work/<yyyy-mm-short-name>/` one folder per change: intent.md, spec.md, plan.md, qa-report.md
- `docs/ai/` reference docs: read `docs/ai/architecture.md` before cross-module changes
- Never edit generated code under `**/generated/**`; run `make codegen` instead

## Conventions
- <Only conventions that differ from language defaults, e.g. "errors are returned as Result, never thrown">
- <Naming, module boundaries, logging rules>

## Workflow
- Non-trivial changes start in plan mode and follow `work/<change>/plan.md`. If the implementation departs from the plan, update plan.md in the same commit.
- Bug fixes start with a failing test, committed first.
- One logical change per commit. Commit subject: `<area>: <imperative summary>`.
- Agent-written changes reach `main` only through a PR. Never push to `main`.

## Gotchas
- <Non-obvious behaviour that has bitten people, e.g. "tests need a local Redis: `make deps-up`">

## When compacting
Always keep: the list of modified files, the active work/ folder, and the test commands used.
