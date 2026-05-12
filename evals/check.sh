#!/usr/bin/env bash
# Runs every evals/tasks/*.json in a throwaway git worktree and scores it with its own check command.
# Task file shape:
#   { "id": "...", "prompt": "...", "allowed_tools": "Edit,Bash(make test *)", "check": "make test FILE=..." }
# Requires: jq, git, claude. Exit code = number of failed evals (0 = all passed).
set -uo pipefail

root="$(git rev-parse --show-toplevel)"
fails=0

for task in "$root"/evals/tasks/*.json; do
  id="$(jq -r .id "$task")"
  dir="$(mktemp -d)"
  git -C "$root" worktree add --detach "$dir" HEAD >/dev/null 2>&1

  ( cd "$dir" && claude -p "$(jq -r .prompt "$task")" \
      --allowedTools "$(jq -r '.allowed_tools // "Edit,Write,Read,Grep,Glob"' "$task")" \
      --permission-mode dontAsk --max-turns 40 --output-format json > "$dir/.eval-output.json" 2>&1 )

  if ( cd "$dir" && bash -c "$(jq -r .check "$task")" ) >/dev/null 2>&1; then
    echo "PASS  $id"
  else
    echo "FAIL  $id"
    fails=$((fails + 1))
  fi

  git -C "$root" worktree remove --force "$dir" >/dev/null 2>&1
done

echo "Failed: $fails"
exit "$fails"
