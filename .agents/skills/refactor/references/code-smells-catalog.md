# Code Smells Catalog & Refactoring Patterns

> Extracted from SKILL.md — loaded on demand when performing specific refactoring operations.

## Common Code Smells & Fixes

### 1. Long Method/Function

```diff
# BAD: 200-line function that does everything
- async function processOrder(orderId) {
-   // 50 lines: fetch order
-   // 30 lines: validate order
-   // 40 lines: calculate pricing
-   // 30 lines: update inventory
-   // 20 lines: create shipment
-   // 30 lines: send notifications
- }

# GOOD: Broken into focused functions
+ async function processOrder(orderId) {
+   const order = await fetchOrder(orderId);
+   validateOrder(order);
+   const pricing = calculatePricing(order);
+   await updateInventory(order);
+   const shipment = await createShipment(order);
+   await sendNotifications(order, pricing, shipment);
+   return { order, pricing, shipment };
+ }
```

### 2. Duplicated Code
Extract common logic into shared functions.

### 3. Large Class/Module
Split into single-responsibility classes (UserService, EmailService, PaymentService).

### 4. Long Parameter List
Group related parameters into objects or use builder pattern.

### 5. Feature Envy
Move logic to the object that owns the data.

### 6. Primitive Obsession
Use domain types (Email, PhoneNumber) instead of raw strings.

### 7. Magic Numbers/Strings
Replace with named constants.

### 8. Nested Conditionals
Use guard clauses / early returns.

### 9. Dead Code
Remove unused functions, imports, and commented code. Git history preserves it.

### 10. Inappropriate Intimacy
Use encapsulation — ask, don't tell.

## Design Patterns for Refactoring

### Strategy Pattern
Replace conditional logic with polymorphic strategy classes.

### Chain of Responsibility
Replace nested validation with a chain of validator objects.

## Extract Method Example

```diff
# Before: One long function
- function printReport(users) {
-   // 30 lines of header, active users, inactive users
- }

# After: Extracted methods
+ function printReport(users) {
+   printHeader('USER REPORT');
+   printUserSection('ACTIVE USERS', users.filter(u => u.isActive));
+   printUserSection('INACTIVE USERS', users.filter(u => !u.isActive));
+ }
```

## Type Safety Introduction

Move from untyped functions to full TypeScript interfaces with proper return types.

## Common Refactoring Operations

| Operation | Description |
|-----------|-------------|
| Extract Method | Turn code fragment into method |
| Extract Class | Move behavior to new class |
| Extract Interface | Create interface from implementation |
| Inline Method | Move method body back to caller |
| Pull Up Method | Move method to superclass |
| Push Down Method | Move method to subclass |
| Rename Method/Variable | Improve clarity |
| Introduce Parameter Object | Group related parameters |
| Replace Conditional with Polymorphism | Use polymorphism instead of switch/if |
| Replace Magic Number with Constant | Named constants |
| Decompose Conditional | Break complex conditions |
| Replace Nested Conditional with Guard Clauses | Early returns |
| Introduce Null Object | Eliminate null checks |
| Replace Type Code with Class/Enum | Strong typing |
| Replace Inheritance with Delegation | Composition over inheritance |
