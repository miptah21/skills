---
description: Context engineering workflow for complex multi-step tasks. Use when tasks involve 3+ steps, multiple tool calls, or risk of context drift.
---

# Planning Workflow — Context Engineering for Long Tasks

> Use when tasks involve 3+ steps, multiple tool calls, or risk of context drift.
> Based on Manus context engineering principles.

---

## When to Trigger

- Multi-step tasks (3+ phases)
- Research tasks with synthesis
- Feature development across multiple files
- Tasks where you might lose track of the goal after many tool calls

**Skip for**: Simple questions, single-file edits, quick lookups.

---

## Core Principles

### 1. Read Before Decide

Before any major decision, **re-read your plan file**. After ~20+ tool calls, the original goal drifts out of the attention window. Reading the plan brings it back.

```
[Many tool calls have happened...]
[Context is getting long...]
[Original goal might be forgotten...]

→ Read task.md                # Goals are fresh in attention again
→ Now make the decision       # With full clarity
```

### 2. Store, Don't Stuff

Large outputs go to **files**, not context. Keep only paths in working memory.

| Don't | Do |
|-------|-----|
| Keep 500 lines of search results in context | Write findings to `scratch/notes.md`, reference the path |
| Re-read the same large file repeatedly | Extract key points to notes, reference notes |
| Accumulate all data before acting | Save incrementally, read what you need |

### 3. Keep Failure Traces

Every error goes in the task file. Don't hide failures — they inform better decisions.

```markdown
## Errors Encountered
- [FileNotFoundError] config.json not found → Created default config
- [API timeout] Auth endpoint → Retried with backoff, succeeded on 2nd attempt
```

### 4. Update After Act

After completing any phase, **immediately** update the task file:
- Mark completed items with `[x]`
- Update the current status
- Log any errors encountered

---

## The 3-File Pattern

For complex tasks, use three files for persistent working memory:

| File | Purpose | When to Update |
|------|---------|----------------|
| `task.md` | Track phases and progress | After each phase |
| `scratch/notes.md` | Store findings and research | During research |
| Deliverable (artifact/code) | Final output | At completion |

> **Note**: Antigravity's Planning Mode already creates `task.md` and `implementation_plan.md`. Use those as your primary plan files. Create `scratch/notes.md` only when you need to store large intermediate research.

---

## Workflow

```
Loop 1: Create/update task.md with goal and phases
Loop 2: Research → save to notes → update task.md
Loop 3: Read notes → build deliverable → update task.md
Loop 4: Verify → deliver → mark complete
```

### Before Each Major Action
```
1. Read task.md              # Refresh goals in attention window
2. Check current phase       # Know where you are
3. Execute the action        # Do the work
4. Update task.md            # Mark progress
```

---

## Task Plan Template

```markdown
# Task: [Brief Description]

## Goal
[One sentence describing the end state]

## Phases
- [ ] Phase 1: Research and plan
- [ ] Phase 2: Implement core changes
- [ ] Phase 3: Verify and test
- [ ] Phase 4: Polish and deliver

## Key Decisions
- [Decision]: [Rationale]

## Errors Encountered
- [Error]: [Resolution]

## Status
**Currently in Phase X** — [What I'm doing now]
```

## Notes Template

```markdown
# Notes: [Topic]

## Source 1: [Name/URL]
- Key finding 1
- Key finding 2

## Source 2: [Name/URL]
- Key finding 1

## Synthesis
- [Overall conclusion from research]
```

---

## Anti-Patterns

| Don't | Do Instead |
|-------|------------|
| State goals once and forget | Re-read plan before each decision |
| Hide errors and retry silently | Log errors to plan file |
| Stuff everything in context | Store large content in files |
| Start executing immediately | Create plan file FIRST |
| Batch-update progress at the end | Update after EACH phase |
