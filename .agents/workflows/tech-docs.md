---
description: Technical documentation writing workflow. Use when creating README files, API docs, architecture docs, or user guides.
---

# Technical Documentation Workflow

> Use when creating README files, API docs, architecture docs, or user guides.
> Goal: Produce accurate, verified, developer-friendly documentation.

---

## When to Trigger

- User asks to document a feature, API, or module
- User says "write README", "document this", "create API docs"
- New project needs initial documentation
- Existing docs are outdated and need updating

---

## Documentation Types

### README Files
- **Structure**: Title, Description, Installation, Usage, API Reference, Contributing, License
- **Tone**: Welcoming but professional
- **Focus**: Getting users started quickly with clear examples

### API Documentation
- **Structure**: Endpoint, Method, Parameters, Request/Response examples, Error codes
- **Tone**: Technical, precise, comprehensive
- **Focus**: Every detail a developer needs to integrate

### Architecture Documentation
- **Structure**: Overview, Components, Data Flow, Dependencies, Design Decisions
- **Tone**: Educational, explanatory
- **Focus**: Why things are built the way they are
- **Tools**: Use mermaid diagrams for visualizing relationships

### User Guides
- **Structure**: Introduction, Prerequisites, Step-by-step tutorials, Troubleshooting
- **Tone**: Friendly, supportive
- **Focus**: Guiding users to success

---

## Workflow

### Step 1: Explore the Code
Before writing any documentation:
- Read the relevant source files
- Understand the public API surface
- Check for existing docs or inline comments
- Note any configuration or setup requirements

**Use maximum parallelism** — read multiple files simultaneously.

### Step 2: Draft the Documentation
- Use the appropriate structure for the doc type
- Include code examples that are **complete and runnable**
- Document both success and error cases
- Use consistent terminology

### Step 3: Verify
This step is **mandatory** — the task is incomplete without verification.

- [ ] All code examples tested or verified against source
- [ ] All file paths and commands are correct
- [ ] All links (internal and external) are valid
- [ ] API request/response examples match actual implementation
- [ ] Installation/setup instructions are accurate

### Step 4: Deliver
- Place documentation in the appropriate location
- If updating existing docs, preserve formatting and style conventions

---

## Quality Checklist

### Clarity
- Can a new developer understand this?
- Are technical terms explained on first use?
- Is the structure logical and scannable?

### Completeness
- All features documented?
- All parameters explained?
- All error cases covered?

### Accuracy
- Code examples verified against source?
- Version numbers current?
- No stale references?

### Consistency
- Terminology consistent throughout?
- Formatting consistent?
- Style matches existing docs?

---

## Style Guide

### Formatting
- Use headers for scanability
- Use fenced code blocks with language identifiers
- Use tables for structured data (parameters, config options)
- Use mermaid diagrams for architecture visualization

### Code Examples
- Start simple, build complexity
- Include both success and error cases
- Show complete, runnable examples
- Add comments explaining non-obvious parts

### Tone
- Professional but approachable
- Direct and confident — avoid hedging
- Use active voice
- No filler words
