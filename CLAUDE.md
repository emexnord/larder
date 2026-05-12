# Team Git Simulation: "Larder"

This repo is a learning sandbox. We simulate a 5-person team building a small product so the git
history and GitHub PR timeline look like a real team's. Nothing here is meant to run.

The Claude Code team setup that lived here before is kept for reference in `CLAUDE-AI-WORK-ONLY.md`
(plus `.claude/`, `.github/`, `docs/`, `REVIEW.md`). It is not loaded automatically; read it when a
stage needs to show the AI workflow (intent → spec → plan → implement → review → QA).

## Learning goals
1. See what a complete team git history looks like: feature branches, PRs, review rounds, conflicts,
   integration fixes and releases, in `git log --graph` and on GitHub.
2. Practise AI-assisted team habits from `CLAUDE-AI-WORK-ONLY.md` inside that history (work folders,
   PR template, small commits, review before merge).

## The product
Larder: a shared household pantry list. Three parts in one repo:
- `backend/` – API (items, households, auth, notifications)
- `frontend/` – web app
- `mobile/` – mobile app
- `ci/`, `.github/workflows/ci.yml` – fake CI

Files use real-looking paths and extensions (`backend/src/items/routes.py`,
`frontend/src/pages/ItemList.tsx`, `mobile/src/screens/ItemList.kt`), but each file holds only
one word or one sentence, usually a comment such as `# returns all pantry items`. Tests mirror
`src/` under `tests/` per part and are equally trivial. A "change" means editing or adding such lines.

## The team
| Dev | Role | Usual area |
| --- | --- | --- |
| Emexnord | Lead | Reviews, merges, releases, repo setup; sometimes features |
| Amara Okafor | Backend | `backend/` |
| Lukas Brandt | Frontend | `frontend/` |
| Sana Qureshi | Mobile | `mobile/` |
| Diego Ramos | Full-stack | cross-cutting features, CI, integration fixes |

Identities: emails are `<firstname>@larder.example` (Emexnord: `emexnord@larder.example`). Never use a
real personal email. Commit as a dev with:
`git -c user.name="Amara Okafor" -c user.email="amara@larder.example" commit -m "..."`

## Hard rules
- `main` and `develop` change only through merged PRs. The only exceptions: Emexnord's bootstrap
  commits on `main` before `develop` exists, and the initial push of `develop`.
- Every branch is cut from an up-to-date `develop` (release PRs go `develop` → `main`).
- Emexnord follows the same rules when he writes code: own branch, own PR, a teammate reviews it.
- PRs are merged with a merge commit (`gh pr merge <n> --merge --delete-branch`). No squash or
  rebase merges, so the graph keeps every branch.
- Never rewrite shared history: no force push, no rebase of a pushed branch. Catch up by merging
  `develop` into the feature branch.
- CI is fake: jobs only `echo` success. A PR merges only when CI is green and it has an approval.

## Conventions
- Branches: `feature/<area>-<short-name>`, `fix/<area>-<short-name>`, `chore/<short-name>`,
  `hotfix/<short-name>` (from `main`, only if a stage needs it).
- Commit subject: `<area>: <imperative summary>`, area in backend|frontend|mobile|ci|repo|docs|
  release. Body only when the why is not obvious. One logical change per commit.
- PR title: same style as a commit subject. PR body follows `.github/pull_request_template.md`
  (short, fake-but-plausible answers).
- Non-trivial features carry a `work/<yyyy-mm-short-name>/` folder with one-line `intent.md` and
  `plan.md` (and `spec.md` when it is cross-team), committed first on the branch.
- Reviews: one GitHub account plays everyone, so GitHub blocks approving or requesting changes on
  your own PR. Post reviews as comments: `gh pr review <n> --comment -b "[Review by Emexnord]
  Changes requested: ..."` (or `gh pr comment`), ending with `Approved.` when approved.
- Releases: PR `develop` → `main` titled `release: vX.Y.0`, after a "preview test" comment on the
  PR. After merge, tag `main` (`git tag -a vX.Y.0`) and push the tag.
- Merge commits are not counted, so make each real commit carry a meaningful small change.

## Target for round 1
- **100 non-merge commits** across all branches, plus however many merge commits that produces.
  Check with `git rev-list --count --no-merges --all`.
- Roughly 20–25 PRs, about 2–3 releases to `main` (e.g. v0.1.0 bootstrap tag, v0.2.0, v0.3.0).
- Rough share: Emexnord ~15–20 commits (bootstrap + a few features + fixes), others ~20 each.
- Every scenario below appears at least once, ideally spread through the timeline:
  - [ ] Feature branch falls behind `develop` while others merge
  - [ ] Dev merges `develop` into their feature branch to catch up
  - [ ] Merge conflict, resolved in a visible merge commit with a clear message
  - [ ] Reviewer requests changes twice before approving
  - [ ] Reviewer pushes their own commit to a contributor's branch
  - [ ] Integration fix after several PRs land and break each other (fake CI note says why)
  - [ ] Release PR bundling several previously merged features
  - [ ] Two devs working in parallel on the same part (e.g. backend auth vs backend items)
  - [ ] Cross-part feature split over backend, frontend and mobile PRs
  - [ ] Emexnord's own feature PR reviewed by a teammate
  - Optional: hotfix from `main`, merged back into `develop`; a PR closed without merge

## Rough shape of the story (guide, not script)
1. Bootstrap (Emexnord on `main`): commit this Claude setup with a proper `.gitignore`, then the
   three-part skeleton, fake CI and CODEOWNERS with real team handles. Tag `v0.1.0`.
2. Emexnord creates `develop`, sets branch protection on GitHub for `main` and `develop`
   (require PR, require the fake CI check; no required approvals, since one account plays all).
3. Onboarding: each new dev's first PR is small (e.g. a README line about their area).
4. Feature waves: parallel feature PRs, review rounds, catch-up merges, conflicts, integration fixes.
5. Release when a coherent set of features is on `develop`; then the next wave.

Exact files, counts per stage and order are flexible. Correct mechanics and a believable story
matter more than hitting the plan precisely. Adjust the remaining stages to the checklist and
the commit count actually reached.

## How each stage is delivered
For every stage give:
1. A script that creates or edits the files (bash heredocs, one-line contents).
2. The exact git and `gh` commands, in order, with the dev identity on each commit.
3. What happened in the history and why a real team would do it this way.
4. What to look for in `git log --graph --oneline --all` and on GitHub (PR page, Network graph).

Early stages: the user runs the commands and pastes output. Later the user may hand execution to
Claude; then Claude runs them, and asks before pushes and merges. Before each new stage, read the
current state from git (`git log`, `gh pr list --state all`) rather than from memory.

## Gotchas
- `.claude/hooks/block-dangerous-bash.sh` blocks any command containing `push ... main`. Bootstrap
  pushes to `main` are run by the user; later `main` changes go through release PRs anyway.
- The three Claude workflows in `.github/workflows/` are gated with `if: false` (no API key). Leave
  them off; the fake `ci.yml` is the only check.
- Do not write extra docs about the simulation. This file is the plan; git is the progress log.
