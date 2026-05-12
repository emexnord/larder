---
name: qa-check
description: QA a finished change against spec.md acceptance criteria and write work/<change>/qa-report.md with evidence. Use when QA starts on a PR or branch, or when asked to "QA", "test this end to end", or "check acceptance criteria".
argument-hint: "[work folder]"
context: fork
agent: qa-verifier
---

# QA a change

Work folder: $ARGUMENTS

1. Read `spec.md` and list every acceptance criterion.
2. For each criterion, run the check that proves it: automated test, E2E run (`make e2e`), API call against the local app, or a browser check through the browser MCP server. Record the exact command or steps and the observed result.
3. Try the edge cases listed in spec.md plus: empty input, maximum sizes, permission denied, network failure, repeated submission.
4. Write `qa-report.md` from `docs/templates/qa-report.md`: a table of criterion / method / result (Pass, Fail, Blocked) / evidence.
5. File each failure as a reproducible bug note (steps, expected, actual) in the report. Do not fix code in this skill.
6. Final line: `QA result: PASS` only if every criterion passed; otherwise `QA result: FAIL (n issues)`.
   A human QA engineer signs off by approving the PR.
