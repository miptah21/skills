---
description: Product requirements document workflow. Use when planning features, starting new projects, or writing specs.
---

# PRD Workflow — Product Requirements Document

> Use when planning a feature, starting a new project, or when asked to create a PRD.
> Goal: Generate a clear, actionable PRD suitable for implementation.

---

## When to Trigger

- "Create a PRD for..."
- "Plan this feature..."
- "Write requirements for..."
- "Spec out..."
- Starting a new project or major feature

---

## Step 1: Receive Feature Description

Get the user's initial feature description. It can be anything from a one-liner to a detailed spec.

## Step 2: Ask Clarifying Questions

Ask 3-5 essential questions where the initial prompt is ambiguous. Use **lettered options** so users can respond quickly (e.g., "1A, 2C, 3B").

Focus on:
- **Problem/Goal**: What problem does this solve?
- **Core Functionality**: What are the key actions?
- **Scope/Boundaries**: What should it NOT do?
- **Target Users**: Who is this for?
- **Success Criteria**: How do we know it's done?

```
1. What is the primary goal of this feature?
   A. Improve user onboarding experience
   B. Increase user retention
   C. Reduce support burden
   D. Other: [please specify]

2. Who is the target user?
   A. New users only
   B. Existing users only
   C. All users
   D. Admin users only

3. What is the scope?
   A. Minimal viable version
   B. Full-featured implementation
   C. Just the backend/API
   D. Just the UI
```

**Rules**:
- Only ask questions where the answer genuinely changes the PRD
- Indent the options for readability
- Skip questions that are already answered in the feature description
- Adapt questions to the specific feature (don't use generic templates blindly)

## Step 3: Generate the PRD

After receiving answers, generate the PRD with these sections:

---

### PRD Template

```markdown
# PRD: [Feature Name]

## Introduction
Brief description of the feature and the problem it solves.

## Goals
- Specific, measurable objective 1
- Specific, measurable objective 2

## User Stories

### US-001: [Title]
**Description:** As a [user], I want [feature] so that [benefit].

**Acceptance Criteria:**
- [ ] Specific verifiable criterion
- [ ] Another criterion
- [ ] Typecheck/lint passes

### US-002: [Title]
...

## Functional Requirements
- FR-1: The system must allow users to...
- FR-2: When a user clicks X, the system must...

## Non-Goals (Out of Scope)
- What this feature will NOT include
- Critical for managing scope

## Technical Considerations (Optional)
- Known constraints or dependencies
- Integration points with existing systems
- Performance requirements

## Design Considerations (Optional)
- UI/UX requirements
- Relevant existing components to reuse

## Success Metrics
- How will success be measured?
- "Reduce time to complete X by 50%"

## Open Questions
- Remaining questions or areas needing clarification
```

---

## Story Sizing Guidelines

Each user story should be **small enough to implement in one focused session**.

### Right-sized stories:
- Add a database column and migration
- Add a UI component to an existing page
- Update a server action with new logic
- Add a filter dropdown to a list

### Too big (split these):
- "Build the entire dashboard" → Split into: schema, queries, UI components, filters
- "Add authentication" → Split into: schema, middleware, login UI, session handling
- "Refactor the API" → Split into one story per endpoint or pattern

**Rule of thumb:** If you cannot describe the change in 2-3 sentences, it's too big.

## Story Ordering

Stories execute in dependency order. Earlier stories must not depend on later ones.

**Correct order:**
1. Schema/database changes (migrations)
2. Server actions / backend logic
3. UI components that use the backend
4. Dashboard/summary views that aggregate data

## Acceptance Criteria Rules

Each criterion must be **verifiable**, not vague.

| ✅ Good (verifiable) | ❌ Bad (vague) |
|----------------------|----------------|
| "Add `status` column to tasks table with default 'pending'" | "Works correctly" |
| "Filter dropdown has options: All, Active, Completed" | "User can do X easily" |
| "Clicking delete shows confirmation dialog" | "Good UX" |
| "Typecheck passes" | "Handles edge cases" |

---

## Output

- **Format**: Markdown (`.md`)
- **Location**: Save as artifact or to `tasks/` directory
- **Filename**: `prd-[feature-name].md` (kebab-case)
- **Important**: Do NOT start implementing. Just create the PRD.

---

## Checklist Before Saving

- [ ] Asked clarifying questions with lettered options
- [ ] Incorporated user's answers
- [ ] User stories are small and specific (one focused session each)
- [ ] Stories ordered by dependency (schema → backend → UI)
- [ ] Functional requirements are numbered and unambiguous
- [ ] Acceptance criteria are verifiable (not vague)
- [ ] Non-goals section defines clear boundaries
