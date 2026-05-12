# How our Claude Code setup works

Owner (DRI): <name> - changes to `.claude/`, `CLAUDE.md`, `REVIEW.md` need their review (see CODEOWNERS).
Last full review: <date>. Next review: <date + 3 months>, or after a major model release.

## Layers
| Layer | Where | Who changes it |
| --- | --- | --- |
| Org policy | managed settings (IT / platform) | Platform team |
| Shared tooling | `acme-workflow` plugin from the internal marketplace | Platform team, via plugin releases |
| This repo | `CLAUDE.md`, `.claude/`, `.mcp.json`, `REVIEW.md` | Anyone, via PR, owner approves |
| Personal | `CLAUDE.local.md`, `.claude/settings.local.json`, `~/.claude/` | Each developer |

## Flow of a change
intent.md (/write-intent) -> spec.md (/write-spec) -> plan.md (/plan-feature, plan mode)
-> code (/implement, /verify) -> PR (/open-pr) -> review (code-reviewer agent + Code Review/CI + human owner)
-> QA (/qa-check + human QA sign-off) -> release (/release, release manager only)

## Enabling the shared plugin (when the org marketplace exists)
Add to `.claude/settings.json`:
```json
"extraKnownMarketplaces": {
  "acme-tools": { "source": { "source": "github", "repo": "acme-corp/claude-plugins" } }
},
"enabledPlugins": { "acme-workflow@acme-tools": true }
```

## Personal setup checklist
1. Install `jq` (hooks need it) and the language server for our stack (code intelligence plugin).
2. Trust the folder when Claude Code asks; project allow rules and plugins wait for trust.
3. Set the env vars `.mcp.json` uses (see `.env.example`), then approve the project MCP servers.
4. Run `/context` once to confirm CLAUDE.md and rules loaded.

## Changing the setup
- Repeated Claude mistake -> one line in CLAUDE.md or a rule.
- Same prompt typed three times -> a skill.
- Must happen every time -> a hook.
- Needed in a second repo -> move it to the plugin.
- Every change to `.claude/` runs the eval suite in CI (`.github/workflows/agent-evals.yml`).
