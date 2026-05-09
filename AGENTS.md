# Antigravity AGENTS.md

## Project Overview
This repository is a comprehensive **Agentic Engineering Skills Library** — a curated collection of 103 specialized AI agent skills compatible with modern AI coding assistants (Antigravity, Claude Code, Cursor, Cline, Codex, etc.). Skills cover the full engineering stack: data engineering (dbt, Airflow, Snowflake), frontend (React, Next.js), financial analysis, document generation, DevOps, and more.

## Core Agent Behavior & Interaction
- **Progressive Disclosure:** Do not assume context. When interacting with this repository, always rely on the specialized skills stored in `.agents/skills/`. Read the `SKILL.md` of the relevant skill before executing complex tasks.
- **Modularity:** Treat agent skills as code. Maintain separation of concerns between deterministic tasks (e.g., executing Python scripts) and LLM-driven reasoning.
- **Shared Vocabulary:** Read `.agents/skills/CONTEXT.md` for domain terms, architecture context, and coding conventions.

## Phase 0 — Intent Gate (EVERY message)

Before doing anything, classify the request:

| Type | Signal | Action |
|------|--------|--------|
| **Trivial** | Single file, known location, direct answer | Execute directly |
| **Explicit** | Specific file/line, clear command | Execute directly |
| **Exploratory** | "How does X work?", "Find Y" | Research first |
| **Open-ended** | "Improve", "Refactor", "Add feature" | Assess codebase first |
| **Ambiguous** | Unclear scope, multiple interpretations | Ask ONE clarifying question |

### Ambiguity Check

| Situation | Action |
|-----------|--------|
| Single valid interpretation | Proceed |
| Multiple interpretations, similar effort | Proceed with default, note assumption |
| Multiple interpretations, 2x+ effort difference | **MUST ask** |
| Missing critical info | **MUST ask** |
| User's design seems flawed | **MUST raise concern** before implementing |

## Executable Commands (with RTK Compression)
When running terminal commands to analyze the workspace, you MUST prefix them with `rtk` to reduce token consumption by 60-90%. 
- **Environment:** Use the local workspace configuration.
- **Python/ETL Tasks:** Use `rtk python <script.py>` or `rtk pytest`.
- **DAG Testing:** Always run `rtk python <dag_file.py>` before finalizing orchestration changes.
- **Git & Logs:** Use `rtk git status`, `rtk git diff`, `rtk read <file>`, `rtk grep <pattern>`.

## Coding Style, Standards & Boundaries
> **Single source of truth:** See `.agents/skills/CONTEXT.md` for all coding conventions, architecture context, and "Don't Touch" boundaries.
> **Skill Size Constraints:** A `SKILL.md` file must rarely exceed 250 lines. Any exhaustive tables, advanced schemas, or dialect-specific references MUST be placed in a `references/` directory next to the skill and linked via a `> **Reference:**` block.

## Detailed Conventions
See `docs/` for in-depth guides:
- `docs/implementation-protocol.md` — Pre-impl checks, delegation, verification, failure recovery
- `docs/communication-style.md` — Agent communication standards (includes Caveman mode)
- `docs/rtk-optimization.md` — RTK command mapping reference
- `docs/comment-policy.md` — When comments are acceptable vs unacceptable

The following **skills** also act as foundational project conventions:
- `clean-code` — Pragmatic coding standards (SRP, DRY, KISS, YAGNI)
- `git-workflow` — Repository standards for commits, branches, and PRs
- `tdd` — Test-Driven Development lifecycle (Red-Green-Refactor)
- `git-guardrails-claude-code` — Safety conventions preventing destructive git operations

## Hard Blocks (NEVER violate)

| Constraint | No Exceptions |
|------------|---------------|
| Hardcode secrets or credentials | Never — use env vars or secret managers |
| Execute destructive SQL (`DROP`, `DELETE`, `TRUNCATE`) without human approval | Never |
| Speculate about unread code | Never — read it first |
| Leave code in broken state after failures | Never |
| Commit without explicit user request | Never |

## Skills
Skills are in `.agents/skills/`. Each has a `SKILL.md` with trigger descriptions.
- **Full categorized index:** Read `.agents/skills/README.md`
- **Domain vocabulary:** Read `.agents/skills/CONTEXT.md`

### Quick Routing
When asked to perform a task, match it to the right category:

- **dbt work** → skills starting with `creating-`, `debugging-`, `developing-`, `documenting-`, `migrating-sql-to-`, `refactoring-`, `testing-dbt-*`
- **Airflow/DAGs** → `airflow`, `authoring-dags`, `debugging-dags`, `testing-dags`, `deploying-airflow`, `blueprint`, `airflow-hitl`, `airflow-plugins`, `migrating-airflow-2-to-3`
- **Astronomer** → `managing-astro-local-env`, `managing-astro-deployments`, `setting-up-astro-project`, `troubleshooting-astro-deployments`
- **Cosmos + dbt** → `cosmos-dbt-core`, `cosmos-dbt-fusion`
- **SQL/queries** → `sql-queries`, `finding-expensive-queries`, `optimizing-query-by-id`, `optimizing-query-text`
- **Data analysis** → `analyzing-data`, `statistical-analysis`, `data-visualization`, `data-storytelling`, `powerbi-modeling`
- **Lineage** → `tracing-upstream-lineage`, `tracing-downstream-lineage`, `annotating-task-lineage`, `creating-openlineage-extractors`
- **Observability** → `data-observability`, `checking-freshness`, `profiling-tables`, `warehouse-init`
- **Finance** → `analyzing-financial-statements`, `creating-financial-models`, `variance-analysis`, `reconciliation`
- **Documents** → `docx`, `pptx`, `pdf`, `xlsx`, `excalidraw-diagram-generator`, `canvas-design`, `algorithmic-art`, `image-manipulation-image-magick`, `prd`, `edit-article`
- **Engineering** → `python-expert`, `clean-code`, `refactor`, `ci-cd-pipeline-builder`, `git-workflow`, `pr-review-expert`, `tech-debt-tracker`, `dependency-auditor`, `security-auditor`, `performance-profiler`, `uv-package-manager`, `worktree-manager`, `database-design`, `improve-codebase-architecture`, `tdd`, `diagnose`, `prototype`, `to-issues`, `setup-pre-commit`, `caveman`, `triage`, `zoom-out`, `git-guardrails-claude-code`, `grill-with-docs`
- **Frontend/Web** → `frontend-design`, `web-design-guidelines`, `react-patterns`, `react-useeffect`, `nextjs-best-practices`, `seo-optimizer`, `payload`, `playwright`, `webapp-testing`, `chrome-devtools`, `frontend-performance`, `web-quality-audit`
- **Research & Productivity** → `deep-research`, `agentic-eval`, `skill-writer`, `ag-md-improver`, `grill-me`, `handoff`, `writing-fragments`, `writing-shape`, `writing-beats`, `obsidian-vault`
- **Infrastructure** → `cloud-finops`, `pipeline-orchestration`, `data-governance`, `rca-diagnostics`

### Workflow Triggers
Workflows are situational guides in `.agents/workflows/`. Detect these situations and read the file BEFORE proceeding:

- **Deploying/releasing** → `.agents/workflows/deploy-check.md`
- **Reviewing code/PRs** → `.agents/workflows/code-review.md`
- **Complex multi-step task** → `.agents/workflows/planning.md`
- **Vague feature request** → `.agents/workflows/interview.md`
- **Writing specs/PRD** → `.agents/workflows/prd.md`
- **New project setup** → `.agents/workflows/new-project.md`
- **Evaluating a library** → `.agents/workflows/oss-research.md`
- **Writing documentation** → `.agents/workflows/tech-docs.md`
- **Updating dependencies** → `.agents/workflows/dependency-audit.md`
- **End of major task** → `.agents/workflows/reflect.md`

### Lifecycle Folders
- `_deprecated/` — Retired skills. Do NOT use.

### Background Knowledge (non-invocable)
- `senior-data-engineer` — general data engineering architecture
- `knowledge-synthesis` — cross-source result merging (used by deep-research)
- `search-strategy` — query decomposition (used by deep-research)
