---
name: release
description: Release checklist for production. Only a human release manager runs this.
disable-model-invocation: true
argument-hint: "[version] [ticket]"
---

# Release $ARGUMENTS

Pre-conditions (stop if any fails):
- You were started by the release manager with RELEASE_APPROVED_BY and RELEASE_TICKET set in their shell. The `require-release-approval` hook blocks production deploys otherwise.
- All PRs in this release are merged with a human code-owner approval.
- QA reports for every included change say `QA result: PASS`.

Steps:
1. List merged PRs since the last tag (`git log <last-tag>..HEAD --oneline`) and their work folders.
2. Draft release notes from the intent.md "Outcome" lines. Show them for approval.
3. Tag the version and run the staging deploy. Run smoke checks and paste results.
4. Ask for an explicit "go" from the release manager, then run the production deploy.
5. Run smoke checks again. If anything fails, follow the rollback notes in the plan.md files and stop.
