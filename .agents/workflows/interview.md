---
description: Interactive user interviewing workflow. Use when requirements are vague, scope is unclear, or the user needs guided discovery.
---

# Interview Workflow

> Use when requirements are vague, scope is unclear, or the user says "I want to build X" without specifics.
> Goal: Extract enough detail to produce an actionable implementation plan.

---

## When to Trigger

- User describes a feature/product at high level without technical specifics
- Multiple valid interpretations exist with significantly different effort
- User says "figure out the best way" or "you decide"
- Greenfield projects with no existing patterns to reference

---

## Interview Protocol

### Step 1: Understand the Core

Ask about the **what** and **why**:

```
Before I start, I need to understand the requirements better.

1. **What problem does this solve?** (user pain point or business goal)
2. **Who uses this?** (end users, admins, developers, API consumers)
3. **What does "done" look like?** (minimum viable version vs full vision)
```

### Step 2: Technical Constraints

Ask about the **how**:

```
Technical questions:

4. **Existing stack?** (framework, database, hosting, auth)
5. **Must integrate with?** (APIs, services, existing codebase)
6. **Performance requirements?** (expected load, latency SLA, offline support)
7. **Data model?** (what entities exist, relationships, volume)
```

### Step 3: UI/UX (if applicable)

```
UI/UX questions:

8. **Design reference?** (existing mockup, competitor to emulate, style preference)
9. **Key user flows?** (what are the 2-3 most important paths)
10. **Responsive?** (mobile-first, desktop-only, both)
```

### Step 4: Scope & Tradeoffs

```
Scope questions:

11. **Timeline?** (MVP deadline, iteration plan)
12. **What can we skip for v1?** (features that can wait)
13. **Known risks?** (regulatory, data sensitivity, third-party dependencies)
```

---

## Rules

1. **Ask in batches** — group related questions, don't ask 13 questions at once
2. **Adapt** — skip questions that are obviously answered or irrelevant
3. **Summarize after each batch** — confirm understanding before asking more
4. **Stop when sufficient** — you don't need answers to everything, just enough to plan
5. **Never assume** — if something is ambiguous and high-impact, ask

## Output

After gathering enough information, produce an **implementation plan** artifact with:
- Summarized requirements (from interview answers)
- Technical architecture
- Phase breakdown (what ships first)
- Open risks / assumptions
