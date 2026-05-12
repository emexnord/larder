# Claude Code team setup template

A starting point for teams that use Claude Code for planning, coding, testing, PR review, QA and release.
It holds only the Claude Code layer, not product code. Replace every `<placeholder>`, `make ...` command
and `acme` name with your own.

## What is where
| Path | Layer | Purpose |
| --- | --- | --- |
| `CLAUDE.md` | repo | Always-loaded project facts (<200 lines) |
| `REVIEW.md` | repo | Review-only rules for Code Review / reviewer agents |
| `.mcp.json` | repo | Team MCP servers; secrets come from env vars |
| `.claude/settings.json` | repo | Permissions, hooks, env (committed) |
| `.claude/rules/` | repo | Topic rules; most load only for matching paths |
| `.claude/skills/` | repo | The workflow: write-intent, write-spec, plan-feature, implement, verify, qa-check, open-pr, release |
| `.claude/agents/` | repo | planner, code-reviewer, security-reviewer, test-writer, qa-verifier, spec-auditor |
| `.claude/hooks/` | repo | Guardrail scripts (need `jq`) |
| `docs/templates/` | repo | intent / spec / plan / qa-report templates |
| `docs/ai/claude-setup.md` | repo | How the setup works and who owns it |
| `evals/` + `.github/workflows/agent-evals.yml` | repo | Tests for the setup itself |
| `.github/` | repo | @claude workflow, PR review workflow, CODEOWNERS, PR template |
| `org/managed-settings.json` | org | Example policy IT deploys (not committed to product repos) |
| `org/claude-plugins/` | org | Internal plugin marketplace for multi-repo sharing |
| `monorepo-example/` | package | Per-package additions for a monorepo |
| `.gitignore.claude-additions` | repo | Lines to add to `.gitignore` |

## Adopt in this order
1. Copy `CLAUDE.md`, `.claude/settings.json`, `.gitignore` lines. Fill in real commands. Make hooks executable:
   `chmod +x .claude/hooks/*.sh evals/check.sh`
2. Add `.claude/rules/`, then the skills and agents you will actually use this month.
3. Add `docs/templates/` and start a `work/<change>/` folder for the next feature.
4. Add `REVIEW.md` and one review path: managed Code Review, or `.github/workflows/claude-review.yml`.
5. Add `.mcp.json` servers one at a time, only for systems Claude cannot reach with a CLI.
6. Add evals from real tasks (aim for 20-50), then `agent-evals.yml`.
7. When a second repo needs the same setup, move the shared parts into `org/claude-plugins/`.
8. Platform/IT deploys `org/managed-settings.json` (or the same JSON via MDM or the claude.ai admin console).

## Check it loaded
Run `claude`, then `/context` (CLAUDE.md and rules), `/skills`, `/agents`, `/hooks`, `/mcp`, `/status` (setting sources).
