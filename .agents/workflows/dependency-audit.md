---
description: Dependency audit workflow. Use when checking project dependencies for vulnerabilities, license issues, or outdated packages.
---

# Dependency Audit Workflow

// turbo-all

## Steps

1. **Read the dependency auditor skill** — Read `.agent/skills/dependency-auditor/SKILL.md` for the full framework.

2. **Vulnerability scan**:
   ```bash
   bun audit
   ```

3. **Check for outdated packages**:
   ```bash
   bun outdated
   ```

4. **License check** (if `license-checker` available):
   ```bash
   bunx license-checker --summary
   ```

5. **Find unused dependencies** (if `depcheck` available):
   ```bash
   bunx depcheck
   ```

6. **Bundle size impact** of largest dependencies:
   ```bash
   # List top direct dependencies by install size
   du -sh node_modules/*/ 2>/dev/null | sort -rh | head -20
   ```

7. **Generate audit report** using the format from the dependency auditor skill.

8. **Prioritize findings**:
   - 🔴 Critical CVEs → Patch immediately
   - 🟡 High severity / EOL deps → Patch within sprint
   - 🟢 Outdated (no security issue) → Plan for next quarter
   - ⚪ Minor updates → Update on next sweep

9. **Create remediation issues** for any high/critical findings.
