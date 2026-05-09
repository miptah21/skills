# 🧠 Agentic Engineering Skills Library

A curated collection of **103 specialized AI agent skills** for [Antigravity](https://antigravity.dev), an advanced agentic AI coding assistant. Skills cover the full engineering stack — from data engineering to frontend development to financial analysis.

## 🏗️ Architecture

```
AGENTS.md                    ← Master routing (Intent Gate + Ambiguity Check)
├── .agents/
│   ├── plugin.json          ← Registry metadata
│   ├── skills/
│   │   ├── CONTEXT.md       ← Shared vocabulary & conventions
│   │   ├── README.md        ← Categorized skills index
│   │   ├── <skill>/
│   │   │   ├── SKILL.md     ← Core instructions (≤250 lines)
│   │   │   └── references/  ← Heavy examples, templates, schemas
│   │   ├── _deprecated/     ← Retired skills
│   └── workflows/           ← Situational workflow guides
└── docs/                    ← Agent convention docs
```

## 📚 Skill Categories

| Category | Skills | Highlights |
|----------|--------|------------|
| **Data Engineering** | 11 | dbt, Snowflake, SQL queries, incremental models |
| **Orchestration** | 11 | Airflow, Blueprint, Cosmos, DAG testing, migration |
| **Astronomer** | 4 | Astro CLI, deployments, local env |
| **Data Analysis** | 5 | Statistics, visualization, storytelling, Power BI |
| **Lineage & Observability** | 8 | OpenLineage, freshness, profiling |
| **Finance** | 4 | DCF, variance analysis, reconciliation |
| **Documents** | 10 | docx, pptx, pdf, xlsx, Excalidraw, canvas, edit-article |
| **Engineering** | 24 | Python, CI/CD, git, security, refactoring, TDD, architecture |
| **Frontend/Web** | 12 | React, Next.js, Payload CMS, SEO, Playwright, performance, web audits |
| **Research & Productivity** | 10 | Deep research, writing pipeline, Obsidian, handoffs |
| **Infrastructure** | 4 | FinOps, governance, RCA diagnostics |

## 🎯 Design Principles

- **Progressive Disclosure** — `AGENTS.md` → `README.md` → `SKILL.md` → `references/`
- **Token Efficiency** — Core skill files stay lean; heavy content lives in `references/`
- **agentskills.io Compliant** — Follows the open standard for agent skill packages
- **Intent Gate** — Every request is classified before action (Trivial / Explicit / Exploratory / Open-ended / Ambiguous)

## 🚀 Usage

1. Copy `.agents/` into your project root
2. Copy `AGENTS.md` to your project root
3. Your AI agent will auto-detect and route tasks to the right skill

## 📋 Conventions

See `docs/` for detailed guides:
- `implementation-protocol.md` — Pre-implementation checks & verification
- `communication-style.md` — Agent communication standards (includes Caveman mode)
- `rtk-optimization.md` — Token compression (60-90% reduction)
- `comment-policy.md` — When comments are acceptable

The following **skills** also act as foundational project conventions:
- `clean-code` — Pragmatic coding standards (SRP, DRY, KISS, YAGNI)
- `git-workflow` — Repository standards for commits, branches, and PRs
- `tdd` — Test-Driven Development lifecycle (Red-Green-Refactor)
- `git-guardrails-claude-code` — Safety conventions preventing destructive git operations

## 📄 License

This repository is completely open-source under the [MIT License](LICENSE).
