---
description: Pre-deployment checklist workflow. Use before deploying to staging or production.
---

# Deploy Check Workflow

// turbo-all

## Steps

1. **Run tests**:
   ```bash
   bun test
   ```

2. **Run linter**:
   ```bash
   bun run lint
   ```

3. **Build production bundle**:
   ```bash
   bun run build
   ```

4. **Security quick-scan** — Read `.agent/skills/security-auditor/SKILL.md` and run:
   ```bash
   # Check for hardcoded secrets
   grep -rnE "(password|secret|api_key|token|private_key)\s*=\s*['\"][^'\"]{8,}" src/

   # Check for eval/exec
   grep -rnE "\beval\(|\bexec\(" src/

   # Check for XSS vectors
   grep -rn "dangerouslySetInnerHTML\|innerHTML\s*=" src/
   ```

5. **Dependency audit**:
   ```bash
   bun audit
   ```

6. **Check environment variables** — Verify all required env vars are set in the target environment:
   ```bash
   # List all env vars referenced in code
   grep -roE "process\.env\.[A-Z_]+" src/ | sort -u
   ```

7. **Check database migrations** — If applicable:
   ```bash
   # Ensure migrations are up to date
   bunx prisma migrate status   # or equivalent
   ```

8. **Bundle size check** — If applicable:
   ```bash
   # Check for unexpected size increases
   bun run build 2>&1 | grep -i "size\|bundle"
   ```

9. **Verify staging** — If deploying to production, verify staging first:
   - Health check endpoint responds
   - Critical user flows work
   - No new errors in logs

10. **Create deployment summary**:
    ```markdown
    ## Deploy Summary
    - **Version**: [tag/commit]
    - **Changes**: [brief list]
    - **Tests**: ✅ Passing
    - **Build**: ✅ Success
    - **Security**: ✅ No findings
    - **Dependencies**: ✅ Audit clean
    - **Migrations**: ✅ Applied / N/A
    ```
