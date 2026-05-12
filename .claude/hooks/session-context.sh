#!/usr/bin/env bash
# SessionStart hook. Plain text printed here is added to Claude's context before the first prompt.
# Keep it short: branch, the active work/ folder for this branch, and its plan status.
cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || exit 0

branch="$(git branch --show-current 2>/dev/null || echo unknown)"
echo "Current branch: $branch"

# Convention: branch name ends with the work folder's short name, e.g. feat/2026-11-checkout-retry
slug="${branch##*/}"
if [[ -d "work/$slug" ]]; then
  echo "Active change folder: work/$slug ($(ls work/"$slug" | tr '\n' ' '))"
  [[ -f "work/$slug/plan.md" ]] || echo "No plan.md yet: run /plan-feature before editing code."
fi
exit 0
