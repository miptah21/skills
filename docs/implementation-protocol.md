# Implementation Protocol

> Loaded on-demand when starting implementation work.
> Referenced from AGENTS.md Code Standards section.

---

## Pre-Implementation Protocol

**Rigorous Coding (MANDATORY before any implementation):**
1. Do not write code before stating assumptions
2. Do not claim correctness you haven't verified
3. Do not handle only the happy path
4. Under what conditions does this work?

**Planning:**
1. If task has 2+ steps → create a structured plan first
2. Mark current work in progress and track completion

## Delegation Prompt Structure

When delegating work (to subagents, or structuring complex tasks), use ALL 7 sections:

```
1. TASK: Atomic, specific goal (one action per delegation)
2. EXPECTED OUTCOME: Concrete deliverables with success criteria
3. REQUIRED SKILLS: Which skill to invoke
4. REQUIRED TOOLS: Explicit tool whitelist
5. MUST DO: Exhaustive requirements — leave NOTHING implicit
6. MUST NOT DO: Forbidden actions — anticipate and block mistakes
7. CONTEXT: File paths, existing patterns, constraints
```

After delegated work completes, ALWAYS verify:
- Does it work as expected?
- Does it follow existing codebase patterns?
- Did it follow MUST DO and MUST NOT DO?

## Code Change Rules

- Match existing patterns (if codebase is disciplined)
- Propose approach first (if codebase is chaotic)
- Never suppress type errors with `as any`, `@ts-ignore`, `@ts-expect-error`
- Never commit unless explicitly requested
- When refactoring: verify safe refactoring before applying

**Bugfix Rule**: Fix minimally. NEVER refactor while fixing a bug. Refactoring and bugfixing are separate tasks.

## Verification Protocol

After making changes, verify:

1. **Changed files compile** — No new type errors or syntax issues
2. **Build passes** — Run build command if available
3. **Tests pass** — Run test suite if available
4. **Both success and error paths work** — Don't just check the happy path

## Evidence Requirements

A task is NOT complete without evidence:

| Action | Required Evidence |
|--------|-------------------|
| File edit | No type errors, builds clean |
| Build command | Exit code 0 |
| Test run | Pass (or explicit note of pre-existing failures) |
| New feature | Demonstrated working as intended |

**NO EVIDENCE = NOT COMPLETE.**

## Failure Recovery

### When Fixes Fail

1. Fix root causes, not symptoms
2. Re-verify after EVERY fix attempt
3. Never shotgun debug (random changes hoping something works)

### After 3 Consecutive Failures

1. **STOP** all further edits immediately
2. **REVERT** to last known working state (git checkout / undo edits)
3. **DOCUMENT** what was attempted and what failed
4. **ASK USER** before proceeding

**Never:**
- Leave code in broken state
- Continue hoping it'll work
- Delete failing tests to "pass"
- Apply random fixes without understanding root cause

## Completion Criteria

A task is complete when:
- All planned items are done
- Build/tests pass (if applicable)
- User's original request fully addressed
- Evidence collected for each change

If verification fails:
1. Fix issues caused by your changes
2. Do NOT fix pre-existing issues unless asked
3. Report: "Done. Note: found N pre-existing issues unrelated to my changes."
