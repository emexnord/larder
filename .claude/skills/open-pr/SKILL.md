---
name: open-pr
description: Open a pull request for the current branch with a description linked to the work folder, verification evidence and risks. Use when work is verified and ready for review.
disable-model-invocation: true
allowed-tools: Bash(git status) Bash(git diff *) Bash(git log *) Bash(git push *) Bash(gh pr create *)
---

# Open a PR

1. Run `/verify`. Stop if it does not pass.
2. Fill `.github/pull_request_template.md`:
   - links to intent.md, spec.md, plan.md in the work folder
   - what changed, in 3-6 bullets
   - verification evidence (commands + results)
   - risks and rollback
   - "AI-assisted: yes" and which parts a human should look at hardest
3. `git push -u origin <branch>` then `gh pr create --title "<area>: <summary>" --body-file <generated body file>`.
4. Do not request merge. Review is by the reviewer agent/Code Review, then a human code owner.
