#!/usr/bin/env bash
# PreToolUse hook (matcher: Bash). Production deploys need a named human approval.
# The release manager sets RELEASE_APPROVED_BY="<name>" and RELEASE_TICKET="<id>" in their own
# shell (never in committed settings) before starting the release session.
set -euo pipefail

input="$(cat)"
cmd="$(printf '%s' "$input" | jq -r '.tool_input.command // ""')"

if [[ "$cmd" =~ (deploy|release).*(prod|production) ]]; then
  if [[ -z "${RELEASE_APPROVED_BY:-}" || -z "${RELEASE_TICKET:-}" ]]; then
    echo "Production deploy blocked: no named release approval (RELEASE_APPROVED_BY / RELEASE_TICKET unset)." >&2
    exit 2
  fi
  mkdir -p "${CLAUDE_PROJECT_DIR:-.}/.claude/logs"
  printf '%s\t%s\t%s\t%s\n' "$(date -u +%FT%TZ)" "$RELEASE_APPROVED_BY" "$RELEASE_TICKET" "$cmd" \
    >> "${CLAUDE_PROJECT_DIR:-.}/.claude/logs/release-approvals.tsv"
fi
exit 0
