# Comment Policy

> Code should be self-documenting. Comments explain **WHY**, not **WHAT**.

## Unacceptable Comments

```typescript
// ❌ Restates code
let count = 0 // Initialize counter to zero

// ❌ Commented-out code (delete it, git has history)
// const oldValue = calculateLegacy(data)

// ❌ Obvious
i++ // Increment i

// ❌ Comment instead of good naming
const d = new Date() // Current date
```

## Acceptable Comments

```typescript
// ✅ Explains WHY (business logic)
// Stripe requires amount in cents, not dollars
const amount = price * 100

// ✅ Explains non-obvious behavior
// setTimeout(0) defers to next tick to avoid React batching issue
setTimeout(flush, 0)

// ✅ Legal/license
// SPDX-License-Identifier: MIT

// ✅ TODO with ticket reference
// TODO(PROJ-123): Replace with batch API when available

// ✅ Warning about gotchas
// WARNING: This function mutates the input array for performance.
// Clone before calling if you need the original.

// ✅ BDD test comments
// #given  #when  #then
```

## Acceptable Documentation Comments

```typescript
// ✅ JSDoc on exported interfaces — describes the contract
/**
 * Validates user credentials and returns a session token.
 * @throws {AuthError} When credentials are invalid
 */
export function authenticate(email: string, password: string): Promise<Session>
```

## Principle

If you need a comment to explain **WHAT** the code does, refactor the code to make it clearer.
If you need a comment to explain **WHY**, that's a good comment.
