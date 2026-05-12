# Monorepo additions

Use the root template as-is at the monorepo root, then add one layer per package:

```
monorepo/
├── CLAUDE.md                         # repo-wide rules only (from the template)
├── .claude/                          # shared settings, rules, skills, agents, hooks (from the template)
└── packages/
    ├── api/
    │   ├── CLAUDE.md                 # API team's conventions (example included)
    │   └── .claude/
    │       ├── settings.json         # self-contained: settings are NOT inherited from the root
    │       └── skills/api-testing/   # package-only skill (example included)
    ├── web/
    │   ├── CLAUDE.md
    │   └── .claude/skills/component-patterns/
    └── shared/
        └── CLAUDE.md
```

- Start Claude from the package folder for package work, from the root for cross-package changes.
- Keep the root `.claude/settings.json` deny rules too: worktree sessions start at the repo root.
- Developers who never touch another team's package can add, in their own `.claude/settings.local.json`:
  `{ "claudeMdExcludes": ["**/packages/web/**"] }`
