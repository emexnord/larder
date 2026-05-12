# Security (always loaded)

- Never read, print or commit secrets. Config values come from environment variables; add new ones to `.env.example` with a placeholder.
- Validate all external input at the boundary (HTTP handlers, queue consumers, CLI args).
- Every new endpoint checks authorization explicitly; never rely on the client.
- Use parameterized queries only. No string-built SQL.
- Do not log request bodies, tokens, or personal data.
- New dependencies: name them in plan.md with the reason; prefer ones already in the lock file.

Enforcement note for maintainers: the hard blocks (secret files, force push, protected paths) are in
`.claude/settings.json` permissions and `.claude/hooks/`. This file is guidance only.
