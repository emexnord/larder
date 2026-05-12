#!/usr/bin/env bash
# PreToolUse hook (matcher: Edit|Write). Blocks edits to protected paths.
# Also enforces "tests are frozen during a bug fix" while the marker file .claude/state/freeze-tests
# exists (the /implement skill creates it after the failing test is committed, and removes it at the end).
set -euo pipefail

input="$(cat)"
path="$(printf '%s' "$input" | jq -r '.tool_input.file_path // .tool_input.path // ""')"
rel="${path#"${CLAUDE_PROJECT_DIR:-$PWD}"/}"

deny() {
  jq -n --arg r "$1" '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$r}}'
  exit 0
}

case "$rel" in
  .env|.env.*|secrets/*)            deny "Secret files are never edited by Claude." ;;
  */generated/*|generated/*)        deny "Generated code: run 'make codegen' instead of editing." ;;
  */migrations/*)
    # Merged migrations are immutable: allow only files that are new (untracked) in git.
    if git -C "${CLAUDE_PROJECT_DIR:-.}" ls-files --error-unmatch "$rel" >/dev/null 2>&1; then
      deny "Merged migration: add a new migration instead of editing $rel."
    fi ;;
  .github/workflows/*|.claude/settings.json|managed-settings.json)
    jq -n --arg r "Changing CI or Claude settings needs explicit human approval." \
      '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"ask",permissionDecisionReason:$r}}'
    exit 0 ;;
esac

if [[ -f "${CLAUDE_PROJECT_DIR:-.}/.claude/state/freeze-tests" && "$rel" =~ (^tests/|\.test\.|\.spec\.|/test_) ]]; then
  deny "Tests are frozen during this bug fix. Change the code, not the test."
fi

exit 0
