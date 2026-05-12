# Internal plugin marketplace (multi-repo setups)

Use this once a second repository needs the same skills, agents or hooks.
It becomes its own git repo (here: `acme-corp/claude-plugins`).

```
claude-plugins/
├── .claude-plugin/marketplace.json        # catalog: lists plugins and where they live
└── plugins/acme-workflow/
    ├── .claude-plugin/plugin.json         # manifest only; everything else sits at the plugin root
    ├── skills/                            # move .claude/skills/* here  -> /acme-workflow:plan-feature
    ├── agents/                            # move .claude/agents/* here
    ├── hooks/hooks.json                   # hook config; scripts referenced via ${CLAUDE_PLUGIN_ROOT}
    └── scripts/                           # move .claude/hooks/*.sh here
```

Steps:
1. Copy the repo-agnostic skills, agents and hook scripts from the template into the folders above.
   Keep repo-specific things (commands, paths, CLAUDE.md, rules) in each repo.
2. Validate: `claude plugin validate .`
3. Require it everywhere through managed settings (`extraKnownMarketplaces` + `enabledPlugins`,
   see `../managed-settings.json`), or per repo in `.claude/settings.json`.
4. Release with semver. For stable vs early-access, host two marketplaces pointing at different refs.

Plugin skills are namespaced (`/acme-workflow:qa-check`), so they never collide with repo skills.
Note: `permissionMode`, `hooks` and `mcpServers` in subagent frontmatter are ignored for plugin subagents;
put guardrails in the plugin's `hooks/hooks.json` instead.
