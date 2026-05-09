# Project Context — Shared Language

> This file defines domain terms, architecture context, and conventions shared across ALL skills.
> Every skill references this vocabulary to ensure consistent behavior.

---

## Domain Terms

| Term | Definition |
|------|-----------|
| **DAG** | Directed Acyclic Graph — an Airflow workflow unit composed of tasks with dependencies |
| **dbt model** | SQL transformation managed by dbt, following the layer convention: `staging` → `intermediate` → `mart` |
| **Warehouse** | Cloud data storage layer (Snowflake, BigQuery, Databricks, or PostgreSQL) |
| **CTE** | Common Table Expression — preferred SQL pattern over nested subqueries |
| **Idempotent** | Operation that produces the same result regardless of how many times it's executed |
| **HITL** | Human-In-The-Loop — approval/reject workflow requiring explicit human action |
| **OpenLineage** | Open standard for data lineage metadata collection |
| **Cosmos** | Astronomer library that renders dbt projects as Airflow DAGs/TaskGroups |
| **SSR / SSG** | Server-Side Rendering / Static Site Generation — Next.js rendering strategies |
| **App Router** | Next.js 13+ routing via `app/` directory with React Server Components |
| **Hydration** | Process of attaching event handlers to server-rendered HTML on client |
| **RSC** | React Server Component — renders on server, zero client JS bundle cost |
| **Core Web Vitals** | Google's UX metrics: LCP (loading), INP (interactivity), CLS (stability) |
| **Schema Markup** | Structured data (JSON-LD) that search engines use for rich results |
| **DCF** | Discounted Cash Flow — valuation method projecting future cash flows to present value |
| **RTK** | Token compression utility prefix — reduces agent output by 60-90% |
| **ADR** | Architecture Decision Record — captures \"why\" a structural choice was made |
| **Vertical Slice** | Tracer bullet code slice that cuts through all layers (DB to UI) |
| **Agent Brief** | Highly specified implementation ticket ready for an AFK agent to pick up |

## Architecture

| Layer | Technology |
|-------|-----------|
| **Frontend** | React + Vite / Next.js App Router |
| **Backend** | FastAPI + PostgreSQL |
| **Orchestration** | Apache Airflow via Astronomer |
| **BI** | Power BI (connected via PostgreSQL) |
| **Data Warehouse** | Snowflake (primary), BigQuery, Databricks, PostgreSQL (local dev) |
| **Documents** | docx (python-docx / docx-js), pptx (python-pptx), pdf (PyMuPDF), xlsx (openpyxl) |
| **Diagrams** | Excalidraw (JSON), Mermaid |
| **CI/CD** | GitHub Actions, GitLab CI |

## Coding Conventions

- **SQL:** CTEs over subqueries. Push filters down early. Optimize for cloud warehouse execution.
- **Python:** Strict type hints. Modular functions. Robust `try/except` for network/API calls.
- **Pipelines:** All data tasks and DAGs MUST be idempotent.
- **Secrets:** NEVER hardcode. Use environment variables or secret managers.
- **Destructive SQL:** `DROP`, `DELETE`, `TRUNCATE` require explicit human approval.

## Skill Loading Protocol

1. Agent receives a task request
2. Agent reads `.agents/skills/README.md` to identify the matching skill by category
3. Agent loads the skill's `SKILL.md` via `view_file` tool
4. Agent follows the skill's workflow instructions
5. If the skill references companion files (`references/`, `scripts/`), load them on-demand
