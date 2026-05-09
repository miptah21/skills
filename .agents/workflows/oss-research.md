---
description: Open-source library research workflow. Use when researching libraries, finding implementation details, or evaluating packages.
---

# OSS Research Workflow

> Use when researching open-source libraries, finding implementation details, or understanding how external packages work.
> Goal: Answer questions about libraries with evidence and citations.

---

## When to Trigger

- "How does [library] implement X?"
- "What's the best practice for [framework feature]?"
- "Find examples of [library] usage"
- Working with unfamiliar npm/pip/cargo packages
- Need to understand why a library behaves a certain way

---

## Step 1: Classify the Request

| Type | Trigger Examples | Strategy |
|------|------------------|----------|
| **Conceptual** | "How do I use X?", "Best practice for Y?" | `search_web` + `read_url_content` for docs |
| **Implementation** | "How does X implement Y?", "Show me source of Z" | Search GitHub, clone if needed, read source |
| **Context** | "Why was this changed?", "History of X?" | Search issues/PRs, release notes |
| **Comprehensive** | Complex/ambiguous requests | All strategies combined |

---

## Step 2: Research

### For Conceptual Questions
1. `search_web` — find official docs and recent articles
2. `read_url_content` — fetch documentation pages
3. Cross-reference multiple sources

### For Implementation Questions
1. `search_web` — find the GitHub repo
2. `read_url_content` — read specific source files on GitHub
3. If needed: `run_command` with `gh repo clone` for local analysis
4. Construct **GitHub permalinks** to cite specific lines:
   ```
   https://github.com/<owner>/<repo>/blob/<commit-sha>/<filepath>#L<start>-L<end>
   ```

### For Context Questions
1. Search GitHub issues and PRs via `search_web`
2. Read release notes and changelogs
3. Check git blame/log for specific files if cloned

---

## Step 3: Synthesize Findings

### Citation Format

Every claim must include a source:

```markdown
**Claim**: [What you're asserting]

**Evidence** ([source](https://github.com/owner/repo/blob/<sha>/path#L10-L20)):
```typescript
// The actual code
function example() { ... }
```

**Explanation**: This works because [specific reason from the code].
```

---

## Step 4: Deliver

Structure your response as:

```markdown
## Research: [Topic]

### Summary
[Direct answer to the question]

### Evidence
[Code examples with citations]

### Key Findings
1. [Finding with source link]
2. [Finding with source link]

### Caveats
- [Any version-specific notes]
- [Any uncertainty to flag]
```

---

## Rules

1. **Always cite sources** — no unsourced claims about library internals
2. **Use current year** in search queries to avoid outdated results
3. **Cross-validate** — if two sources conflict, note the discrepancy
4. **Flag uncertainty** — if not sure, say so explicitly
5. **Check versions** — library APIs evolve; note which version you're referencing
