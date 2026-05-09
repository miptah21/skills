# 🧠 Agentic Engineering Skills Library

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Skills: 103](https://img.shields.io/badge/Skills-103-success.svg)](.agents/skills)
[![Format: agentskills.io](https://img.shields.io/badge/Format-agentskills.io-yellow.svg)](https://agentskills.io)
[![Compatibility: Universal](https://img.shields.io/badge/Compatibility-Universal_Agents-purple.svg)](#)

A curated collection of **103 specialized AI agent skills** originally designed for [Antigravity](https://antigravity.dev), but fully compatible with **Claude Code, Cursor, Cline, Codex, Aider**, and any other agentic AI assistants. Skills cover the full engineering stack — from data engineering to frontend development to financial analysis.

## 🏗️ Architecture

```text
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

| Category | Skills | Key Technologies / Domains |
|----------|--------|----------------------------|
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

### Prerequisites
- Any agentic assistant compatible with markdown-based instruction protocols (e.g., [Antigravity](https://antigravity.dev), [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code), [Cursor](https://cursor.sh), [Cline](https://github.com/cline/cline), [Codex](https://openai.com/index/openai-codex/), or [Smithery](https://smithery.ai)).

### Installation
1. Copy the `.agents/` directory into your project root.
2. Copy `AGENTS.md` to your project root (acts as the main rule/routing file for your AI).
3. Your AI agent will automatically detect the registry and route your natural language requests to the appropriate skill.

## 🤝 Contributing

We welcome additions to the library! To maintain our token efficiency and structural integrity:
1. Trigger the `skill-writer` agent skill to help you draft the new skill conforming to our conventions.
2. Ensure the `SKILL.md` is strictly **under 250 lines**. Place any dense reference material in a `references/` subdirectory.
3. Register the new skill by updating the `skills_count` and `skill_categories` inside `.agents/plugin.json`.
4. Update this `README.md` and `.agents/skills/README.md` to reflect the new counts.

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
