#!/usr/bin/env bash
# PreToolUse hook (matcher: Bash). Blocks destructive or policy-breaking shell commands.
# Exit code 2 = block; stderr is shown to Claude as the reason. Requires jq.
set -euo pipefail

input="$(cat)"
cmd="$(printf '%s' "$input" | jq -r '.tool_input.command // ""')"

block() {
  echo "Blocked by .claude/hooks/block-dangerous-bash.sh: $1" >&2
  exit 2
}

# Patterns are checked against the whole command string, so they also catch `cd x && ...` chains.
[[ "$cmd" =~ rm[[:space:]]+-[a-zA-Z]*r[a-zA-Z]*f|rm[[:space:]]+-[a-zA-Z]*f[a-zA-Z]*r ]] && block "recursive force delete"
[[ "$cmd" =~ git[[:space:]].*push.*(--force|[[:space:]]-f([[:space:]]|$)) ]] && block "force push"
[[ "$cmd" =~ git[[:space:]].*push.*[[:space:]](main|master)([[:space:]]|$) ]] && block "direct push to main; open a PR instead"
[[ "$cmd" =~ git[[:space:]]+reset[[:space:]]+--hard ]] && block "git reset --hard; ask a human"
[[ "$cmd" =~ (DROP|TRUNCATE)[[:space:]]+(TABLE|DATABASE) ]] && block "destructive SQL"
[[ "$cmd" =~ (cat|less|head|tail|grep)[[:space:]].*\.env([[:space:]]|$|\.) ]] && block "reading env/secret files"
[[ "$cmd" =~ curl.*\|[[:space:]]*(ba)?sh ]] && block "piping a download into a shell"

exit 0
