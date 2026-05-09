# Skills Index

> Categorized index of all active skills. Each skill has a `SKILL.md` with trigger descriptions.
> See [CONTEXT.md](CONTEXT.md) for shared domain vocabulary.

---

## Data Engineering & Warehousing

| Skill | Trigger Keywords |
|-------|-----------------|
| [analyzing-data](analyzing-data/SKILL.md) | "who uses X", "how many Y", "show me Z", SQL analysis, data lookups, metrics |
| [sql-queries](sql-queries/SKILL.md) | Write SQL across all dialects, CTEs, window functions, aggregations |
| [checking-freshness](checking-freshness/SKILL.md) | "is data up to date", "when was table last updated", data recency |
| [profiling-tables](profiling-tables/SKILL.md) | "profile this table", data quality stats, column distributions |
| [warehouse-init](warehouse-init/SKILL.md) | Schema discovery setup, generate warehouse.md metadata |
| [cloud-finops](cloud-finops/SKILL.md) | Rightsizing warehouses, auto-suspend, storage optimization, budget alerts |
| [pipeline-orchestration](pipeline-orchestration/SKILL.md) | Dagster, Prefect, custom schedulers (NOT Airflow) |
| [data-governance](data-governance/SKILL.md) | RBAC, data contracts, PII/PHI masking, GDPR/CCPA compliance |
| [data-observability](data-observability/SKILL.md) | Great Expectations, Soda checks, schema drift, anomaly detection |

## Snowflake Query Optimization

| Skill | Trigger Keywords |
|-------|-----------------|
| [finding-expensive-queries](finding-expensive-queries/SKILL.md) | "top queries", "most expensive", "slowest queries", query history |
| [optimizing-query-by-id](optimizing-query-by-id/SKILL.md) | Snowflake query_id (UUID), query profile, performance metrics |
| [optimizing-query-text](optimizing-query-text/SKILL.md) | "optimize this SQL", "make faster", anti-pattern review |

## dbt Lifecycle

| Skill | Trigger Keywords |
|-------|-----------------|
| [creating-dbt-models](creating-dbt-models/SKILL.md) | "create", "build", "add", "new" model/table/SQL |
| [debugging-dbt-errors](debugging-dbt-errors/SKILL.md) | "fix", "error", "broken", "failing", compilation/database errors |
| [developing-incremental-models](developing-incremental-models/SKILL.md) | "incremental", "append", "merge", "upsert", late arriving data |
| [documenting-dbt-models](documenting-dbt-models/SKILL.md) | "document", "describe", schema.yml, dbt docs |
| [migrating-sql-to-dbt](migrating-sql-to-dbt/SKILL.md) | "migrate", "convert", legacy SQL, stored procedures to dbt |
| [refactoring-dbt-models](refactoring-dbt-models/SKILL.md) | "refactor", "restructure", "extract", "split" models |
| [testing-dbt-models](testing-dbt-models/SKILL.md) | "test", "validate", unique, not_null, data quality |

## Airflow & Astronomer

| Skill | Trigger Keywords |
|-------|-----------------|
| [airflow](airflow/SKILL.md) | Airflow CLI, list DAGs, trigger runs, task logs, health check |
| [authoring-dags](authoring-dags/SKILL.md) | Create new DAG, write pipeline code, DAG patterns |
| [debugging-dags](debugging-dags/SKILL.md) | Complex DAG failure diagnosis, root cause analysis |
| [testing-dags](testing-dags/SKILL.md) | Multi-step test-debug-fix cycles |
| [deploying-airflow](deploying-airflow/SKILL.md) | Deploy code, CI/CD, production deployment |
| [migrating-airflow-2-to-3](migrating-airflow-2-to-3/SKILL.md) | Airflow 3 migration, upgrade, breaking changes |
| [airflow-hitl](airflow-hitl/SKILL.md) | Human-in-the-loop approval/reject, form input (Airflow 3.1+) |
| [airflow-plugins](airflow-plugins/SKILL.md) | FastAPI apps, custom UI pages, React in Airflow 3.1+ |
| [blueprint](blueprint/SKILL.md) | Reusable task group templates, YAML DAG composition |
| [managing-astro-local-env](managing-astro-local-env/SKILL.md) | Start/stop/restart local Airflow, view logs |
| [managing-astro-deployments](managing-astro-deployments/SKILL.md) | Authenticate, create/update/delete deployments |
| [troubleshooting-astro-deployments](troubleshooting-astro-deployments/SKILL.md) | Production issue diagnosis, deployment logs |
| [setting-up-astro-project](setting-up-astro-project/SKILL.md) | Initialize new Astro projects, configure connections |

## Cosmos & dbt-Airflow Integration

| Skill | Trigger Keywords |
|-------|-----------------|
| [cosmos-dbt-core](cosmos-dbt-core/SKILL.md) | dbt Core project as Airflow DAG via Cosmos |
| [cosmos-dbt-fusion](cosmos-dbt-fusion/SKILL.md) | dbt Fusion on Snowflake/Databricks via Cosmos 1.11+ |

## Data Lineage & Observability

| Skill | Trigger Keywords |
|-------|-----------------|
| [tracing-upstream-lineage](tracing-upstream-lineage/SKILL.md) | "where does data come from", upstream dependencies |
| [tracing-downstream-lineage](tracing-downstream-lineage/SKILL.md) | "what depends on this", impact analysis, change risk |
| [annotating-task-lineage](annotating-task-lineage/SKILL.md) | Inlets/outlets metadata, lineage annotation |
| [creating-openlineage-extractors](creating-openlineage-extractors/SKILL.md) | Custom extractors for unsupported operators |

## Data Analysis & Visualization

| Skill | Trigger Keywords |
|-------|-----------------|
| [statistical-analysis](statistical-analysis/SKILL.md) | Descriptive stats, hypothesis testing, outlier detection |
| [data-visualization](data-visualization/SKILL.md) | matplotlib, seaborn, plotly charts, chart selection |
| [data-storytelling](data-storytelling/SKILL.md) | Narratives from data, stakeholder presentations |
| [powerbi-modeling](powerbi-modeling/SKILL.md) | DAX, star schemas, RLS, semantic models |
| [rca-diagnostics](rca-diagnostics/SKILL.md) | Cross-system incident response, post-mortem RCA |

## Financial Analysis

| Skill | Trigger Keywords |
|-------|-----------------|
| [analyzing-financial-statements](analyzing-financial-statements/SKILL.md) | Financial ratios, investment analysis |
| [creating-financial-models](creating-financial-models/SKILL.md) | DCF, Monte Carlo, sensitivity testing, scenarios |
| [variance-analysis](variance-analysis/SKILL.md) | Budget vs actual, period-over-period, waterfall |
| [reconciliation](reconciliation/SKILL.md) | GL-to-subledger, bank reconciliation |

## Software Engineering & CI/CD

| Skill | Trigger Keywords |
|-------|-----------------|
| [python-expert](python-expert/SKILL.md) | Python code, PEP 8, type hints, data structures |
| [clean-code](clean-code/SKILL.md) | Coding standards, SRP, DRY, KISS, YAGNI |
| [refactor](refactor/SKILL.md) | Surgical code changes, eliminate smells, improve maintainability |
| [ci-cd-pipeline-builder](ci-cd-pipeline-builder/SKILL.md) | GitHub Actions, GitLab CI, pipeline generation |
| [git-workflow](git-workflow/SKILL.md) | Git commits, branches, PRs, conventions |
| [pr-review-expert](pr-review-expert/SKILL.md) | PR/code review, blast radius, breaking change detection |
| [tech-debt-tracker](tech-debt-tracker/SKILL.md) | Tech debt scan, code health, remediation plans |
| [dependency-auditor](dependency-auditor/SKILL.md) | Vulnerabilities, license compliance, outdated packages |
| [security-auditor](security-auditor/SKILL.md) | Security scan, XSS, injection, auth bypass, OWASP |
| [performance-profiler](performance-profiler/SKILL.md) | Bottleneck analysis, P99 latency, memory leaks |
| [uv-package-manager](uv-package-manager/SKILL.md) | uv for Python deps, virtual environments |
| [worktree-manager](worktree-manager/SKILL.md) | Git worktrees, parallel development branches |
| [database-design](database-design/SKILL.md) | Schema design, indexing, ORM, serverless databases |
| [grill-with-docs](grill-with-docs/SKILL.md) | Agent alignment, relentless questioning, inline ADRs |
| [improve-codebase-architecture](improve-codebase-architecture/SKILL.md) | Architectural depth, uncouple modules, find seams |
| [tdd](tdd/SKILL.md) | Strict red-green-refactor loop for application code |
| [diagnose](diagnose/SKILL.md) | Rigorous debugging loop (reproduce, minimise, instrument) |
| [prototype](prototype/SKILL.md) | Build throwaway terminal logic or UI variants to answer design questions |
| [to-issues](to-issues/SKILL.md) | Break plans into independently-grabbable vertical slice GitHub issues |
| [setup-pre-commit](setup-pre-commit/SKILL.md) | Husky, lint-staged, prettier, and typecheck hooks |
| [triage](triage/SKILL.md) | Triage issues through a state machine of triage roles |
| [zoom-out](zoom-out/SKILL.md) | Zoom out to give a broader context or high-level perspective |
| [git-guardrails-claude-code](git-guardrails-claude-code/SKILL.md) | Block dangerous git commands (push, reset --hard) with hooks |

## Frontend & Web Development

| Skill | Trigger Keywords |
|-------|-----------------|
| [frontend-design](frontend-design/SKILL.md) | Web components, pages, production-grade UI |
| [web-design-guidelines](web-design-guidelines/SKILL.md) | UI review, modern design guidelines, layouts |
| [react-patterns](react-patterns/SKILL.md) | React hooks, composition, performance, TypeScript |
| [react-useeffect](react-useeffect/SKILL.md) | useEffect best practices, when NOT to use Effect |
| [nextjs-best-practices](nextjs-best-practices/SKILL.md) | Next.js App Router, Server Components, data fetching |
| [seo-optimizer](seo-optimizer/SKILL.md) | SEO strategy, keywords, meta tags, schema markup |
| [payload](payload/SKILL.md) | Payload CMS — collections, hooks, access control |
| [playwright](playwright/SKILL.md) | Browser automation, E2E testing via terminal |
| [webapp-testing](webapp-testing/SKILL.md) | Playwright-based local UI debugging, screenshots |
| [chrome-devtools](chrome-devtools/SKILL.md) | Chrome DevTools MCP, network profiling, debugging |

## Document Generation

| Skill | Trigger Keywords |
|-------|-----------------|
| [docx](docx/SKILL.md) | Word documents, .docx, reports, memos |
| [pptx](pptx/SKILL.md) | PowerPoint, slide decks, presentations |
| [pdf](pdf/SKILL.md) | PDF read/create/merge/split, OCR, forms |
| [xlsx](xlsx/SKILL.md) | Excel/spreadsheets, .xlsx/.csv/.tsv |
| [excalidraw-diagram-generator](excalidraw-diagram-generator/SKILL.md) | Diagrams, flowcharts, mind maps |
| [canvas-design](canvas-design/SKILL.md) | Visual art, posters, .png/.pdf design |
| [algorithmic-art](algorithmic-art/SKILL.md) | Generative art, p5.js, flow fields, particle systems |
| [image-manipulation-image-magick](image-manipulation-image-magick/SKILL.md) | Image resize, convert, batch process via ImageMagick |
| [prd](prd/SKILL.md) | Product Requirements Documents |
| [edit-article](edit-article/SKILL.md) | Edit and improve articles, restructure sections |

## Research & Productivity

| Skill | Trigger Keywords |
|-------|-----------------|
| [deep-research](deep-research/SKILL.md) | Multi-source synthesis, citations, investigation |
| [agentic-eval](agentic-eval/SKILL.md) | Self-critique, evaluator-optimizer, quality loops |
| [skill-writer](skill-writer/SKILL.md) | Create/author new SKILL.md files, skill structure |
| [ag-md-improver](ag-md-improver/SKILL.md) | Audit and improve AGENTS.md files |
| [caveman](caveman/SKILL.md) | Ultra-compressed communication mode. Cuts token usage ~75% |
| [grill-me](grill-me/SKILL.md) | Relentless interviewing to resolve every branch of a decision tree |
| [handoff](handoff/SKILL.md) | Compact current session into a context handoff doc for next agent |
| [writing-fragments](writing-fragments/SKILL.md) | Grilling session to mine for raw material and sharp ideas |
| [writing-shape](writing-shape/SKILL.md) | Shape raw material into a drafted article, block by block |
| [writing-beats](writing-beats/SKILL.md) | Choose-your-own-adventure style article generation from notes |
| [obsidian-vault](obsidian-vault/SKILL.md) | Search, create, and manage notes in an Obsidian vault |

## Background Knowledge (non-invocable)

These provide context but are not directly triggered by users:

| Skill | Used By |
|-------|---------|
| [senior-data-engineer](senior-data-engineer/SKILL.md) | General data engineering architecture |
| [knowledge-synthesis](knowledge-synthesis/SKILL.md) | Used by deep-research for merging results |
| [search-strategy](search-strategy/SKILL.md) | Used by deep-research for query decomposition |

---

## Workflows

Workflows are situational guides in `.agents/workflows/`. Agents detect matching situations and read the workflow file:

| Situation | Workflow |
|-----------|----------|
| About to deploy, pushing to prod | [deploy-check.md](../workflows/deploy-check.md) |
| Reviewing changes, checking PR | [code-review.md](../workflows/code-review.md) |
| Task has 3+ steps, complex changes | [planning.md](../workflows/planning.md) |
| User describes feature vaguely | [interview.md](../workflows/interview.md) |
| User wants a spec/requirements | [prd.md](../workflows/prd.md) |
| Starting a fresh project | [new-project.md](../workflows/new-project.md) |
| Evaluating a library ("should we use X?") | [oss-research.md](../workflows/oss-research.md) |
| Writing README, API docs | [tech-docs.md](../workflows/tech-docs.md) |
| Checking/updating dependencies | [dependency-audit.md](../workflows/dependency-audit.md) |
| End of major task, reflection | [reflect.md](../workflows/reflect.md) |

## Lifecycle

| Folder | Purpose |
|--------|---------|
| `_deprecated/` | Retired skills — do NOT use |
| `_vendor-stubs/` | Unresolved vendor symlinks — not functional |
