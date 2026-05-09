# Security, Gotchas, and Best Practices

## Security Pitfalls

### 1. Local API Access Control (CRITICAL)

**By default, Local API operations bypass ALL access control**, even when passing a user.

```ts
// ❌ SECURITY BUG: Passes user but ignores their permissions
await payload.find({
  collection: 'posts',
  user: someUser, // Access control is BYPASSED!
})

// ✅ SECURE: Actually enforces the user's permissions
await payload.find({
  collection: 'posts',
  user: someUser,
  overrideAccess: false, // REQUIRED for access control
})
```

**When to use each:**

- `overrideAccess: true` (default) - Server-side operations you trust (cron jobs, system tasks)
- `overrideAccess: false` - When operating on behalf of a user (API routes, webhooks)

See [QUERIES.md#access-control-in-local-api](QUERIES.md#access-control-in-local-api).

### 2. Transaction Failures in Hooks

**Nested operations in hooks without `req` break transaction atomicity.**

```ts
// ❌ DATA CORRUPTION RISK: Separate transaction
hooks: {
  afterChange: [
    async ({ doc, req }) => {
      await req.payload.create({
        collection: 'audit-log',
        data: { docId: doc.id },
        // Missing req - runs in separate transaction!
      })
    },
  ]
}

// ✅ ATOMIC: Same transaction
hooks: {
  afterChange: [
    async ({ doc, req }) => {
      await req.payload.create({
        collection: 'audit-log',
        data: { docId: doc.id },
        req, // Maintains atomicity
      })
    },
  ]
}
```

See [ADAPTERS.md#threading-req-through-operations](ADAPTERS.md#threading-req-through-operations).

### 3. Infinite Hook Loops

**Hooks triggering operations that trigger the same hooks create infinite loops.**

```ts
// ❌ INFINITE LOOP
hooks: {
  afterChange: [
    async ({ doc, req }) => {
      await req.payload.update({
        collection: 'posts',
        id: doc.id,
        data: { views: doc.views + 1 },
        req,
      }) // Triggers afterChange again!
    },
  ]
}

// ✅ SAFE: Use context flag
hooks: {
  afterChange: [
    async ({ doc, req, context }) => {
      if (context.skipHooks) return

      await req.payload.update({
        collection: 'posts',
        id: doc.id,
        data: { views: doc.views + 1 },
        context: { skipHooks: true },
        req,
      })
    },
  ]
}
```

See [HOOKS.md#context](HOOKS.md#context).

## Common Gotchas

1. **Local API bypasses access control** unless you pass `overrideAccess: false`
2. **Missing `req` in nested operations** breaks transaction atomicity
3. **Hook loops** — operations in hooks can re-trigger the same hooks; use `req.context` flags
4. **Field-level access** returns boolean only, no query constraints
5. **Relationship depth** defaults to 2; set `depth: 0` for IDs only
6. **Draft status** — `_status` field is auto-injected when drafts are enabled
7. **Types are stale** until you run `generate:types`
8. **MongoDB transactions** require replica set configuration
9. **SQLite transactions** are disabled by default; enable with `transactionOptions: {}`
10. **Point fields** are not supported in SQLite

## Best Practices

### Security

- Default to restrictive access, gradually add permissions
- Use `overrideAccess: false` when passing `user` to Local API
- Field-level access only returns boolean (no query constraints)
- Never trust client-provided data
- Use `saveToJWT: true` for roles to avoid database lookups

### Performance

- Index frequently queried fields
- Use `select` to limit returned fields
- Set `maxDepth` on relationships to prevent over-fetching
- Prefer query constraints over async operations in access control
- Cache expensive operations in `req.context`

### Data Integrity

- Always pass `req` to nested operations in hooks
- Use context flags to prevent infinite hook loops
- Enable transactions for MongoDB (requires replica set) and Postgres
- Use `beforeValidate` for data formatting
- Use `beforeChange` for business logic

### Type Safety

- Run `generate:types` after schema changes
- Import types from generated `payload-types.ts`
- Type your user object: `import type { User } from '@/payload-types'`
- Use `as const` for field options
- Use field type guards for runtime type checking

### Organization

- Keep collections in separate files
- Extract access control to `access/` directory
- Extract hooks to `hooks/` directory
- Use reusable field factories for common patterns
- Document complex access control with comments
