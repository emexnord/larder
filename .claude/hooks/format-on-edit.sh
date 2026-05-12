#!/usr/bin/env bash
# PostToolUse hook (matcher: Edit|Write). Formats the edited file so style never needs a review comment.
# Replace the case arms with your project's formatters. Never fails the tool call.
input="$(cat)"
path="$(printf '%s' "$input" | jq -r '.tool_input.file_path // ""')"
[[ -z "$path" || ! -f "$path" ]] && exit 0

case "$path" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.css|*.md) command -v npx >/dev/null && npx --no-install prettier --write "$path" >/dev/null 2>&1 ;;
  *.py)                                    command -v ruff >/dev/null && ruff format "$path" >/dev/null 2>&1 ;;
  *.go)                                    command -v gofmt >/dev/null && gofmt -w "$path" >/dev/null 2>&1 ;;
esac
exit 0
