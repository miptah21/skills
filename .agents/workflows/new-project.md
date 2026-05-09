---
description: New project setup workflow. Use when starting a fresh project from this template.
---

# New Project Setup

## Steps

1. **Clone the template** and remove template git history:
   ```bash
   # Unix/macOS/Git Bash
   git clone <init-repo-url> my-project
   cd my-project
   rm -rf .git
   git init

   # Windows (PowerShell)
   git clone <init-repo-url> my-project
   cd my-project
   Remove-Item -Recurse -Force .git
   git init
   ```

2. **Update AGENTS.md** — Add project-specific sections:
   - Build & test commands (`bun install`, `bun test`, etc.)
   - Architecture overview (database, API structure, key services)
   - Project-specific conventions (API response format, error codes, etc.)

3. **Update README.md** — Replace the Project Init README with project-specific documentation:
   - Project name and description
   - Setup instructions
   - Environment variables
   - Architecture overview

4. **Setup environment** (if applicable):
   ```bash
   # Create .env.example with your project's required variables, then:
   cp .env.example .env.local
   ```

5. **Install dependencies** (framework-specific):
   ```bash
   # JavaScript/TypeScript
   bun install

   # Python
   python -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt
   ```

6. **Verify build works**:
   ```bash
   bun run build   # or equivalent
   bun test        # if tests exist
   ```

7. **Remove unused convention docs** — If not using React, remove `docs/react-best-practices.md`. If not using TypeScript, remove `docs/typescript-conventions.md`.

8. **Remove unused skills** — Keep only skills relevant to your project type.

9. **Cross-tool compatibility** (optional) — Create symlinks for other AI tools:
   ```bash
   # Linux/macOS/Git Bash
   ln -s AGENTS.md CLAUDE.md
   
   # Windows (PowerShell)
   New-Item -ItemType SymbolicLink -Path "CLAUDE.md" -Target "AGENTS.md"
   ```

10. **Initial commit**:
    ```bash
    git add .
    git commit -m "init: project setup from Project Init template"
    ```

11. **Connect remote**:
    ```bash
    git remote add origin <your-repo-url>
    git push -u origin main
    ```

