---
description: Step-by-step code review workflow. Use when doing code reviews or before merging.
---

# Code Review Workflow

// turbo-all

## Steps

1. **Identify changes** — List all files changed since the target branch:
   ```bash
   git diff --name-only main...HEAD
   git diff --stat main...HEAD
   ```

2. **Read the PR review skill** — Read `.agent/skills/pr-review-expert/SKILL.md` for the full checklist.

3. **Blast radius scan** — For each changed file, find all importers:
   ```bash
   # Find dependents of changed files
   grep -rl "import.*<changed-module>" src/ --include="*.ts" --include="*.tsx"
   ```

4. **Security quick-scan** — Run these grep patterns on the diff:
   ```bash
   git diff main...HEAD | grep -n "eval\|exec\|dangerouslySetInnerHTML\|innerHTML"
   git diff main...HEAD | grep -nE "(password|secret|api_key|token)\s*=\s*['\"]"
   ```

5. **Test coverage check** — Compare source vs test file changes:
   ```bash
   git diff --name-only main...HEAD | grep -v "test\|spec" | wc -l
   git diff --name-only main...HEAD | grep "test\|spec" | wc -l
   ```

6. **Generate report** — Use the PR review output format from the skill.

7. **Review conventions** — Cross-check against `docs/` convention files for style compliance.
