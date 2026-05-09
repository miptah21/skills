---
description: Self-reflection workflow. Use at the end of major tasks or sessions to improve AGENTS.md and project conventions based on lessons learned.
---

# Reflection Workflow

> Use at the end of a session, after a major task, or when explicitly asked with `/reflect`.
> Goal: Turn experience into permanent improvements to project instructions.

---

## When to Trigger

- End of a complex, multi-step task
- After fixing a difficult bug
- When the user corrects the same mistake twice
- After a failed approach that required reverting
- Explicit `/reflect` command

---

## Steps

### Step 1: Analyze the Session

Review what happened:
- What tasks were completed?
- What mistakes were made?
- What corrections did the user provide?
- What patterns worked well?
- What information was missing that would have helped?

### Step 2: Identify Improvements

Categorize findings:

| Category | Example | Where to Update |
|----------|---------|-----------------|
| **Missing convention** | "User prefers X pattern" | `AGENTS.md` Project-Specific Conventions |
| **Missing build command** | "Need to run Y before Z" | `AGENTS.md` Build & Test |
| **Architecture insight** | "Service A depends on B" | `AGENTS.md` Architecture Overview |
| **Repeated mistake** | "Keep forgetting to do X" | Relevant `docs/` file |
| **New gotcha** | "When changing X, also update Y" | `AGENTS.md` Project-Specific Conventions |

### Step 3: Propose Updates

Present findings to the user:

```markdown
## Session Reflection

### What went well
- [Positive observation]

### What could improve
- [Issue]: [Proposed rule/convention to add]

### Proposed AGENTS.md updates
1. Add to Architecture Overview: "[insight]"
2. Add to Project-Specific Conventions: "[gotcha]"
3. Add to Build & Test: "[command]"

Should I apply these updates?
```

### Step 4: Apply (with user approval)

Only update files after the user approves. Update:
- `AGENTS.md` — Architecture, conventions, build commands
- `docs/` files — Convention updates
- `.agent/skills/` — Skill refinements

---

## Rules

1. **Never auto-update without approval** — always propose first
2. **Be specific** — "Add: when modifying auth, also update middleware" not "improve auth docs"
3. **Keep it general** — Only add patterns that will apply to future tasks, not one-off notes
4. **Prune stale rules** — If a convention no longer applies, propose removing it
