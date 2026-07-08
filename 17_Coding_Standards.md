# Discipline OS

# 17_Coding_Standards.md

Version: 1.0

Status: Approved

Document Type:
Coding Standards & Development Guidelines

---

# Table of Contents

1. Purpose

2. General Principles

3. SOLID Principles

4. Clean Code Rules

5. Architecture Rules

6. State Management

7. Dependency Injection

8. Error Handling

9. Logging Standards

10. Git Workflow

11. Commit Convention

12. Code Review Checklist

13. Testing Standards

14. Documentation Standards

15. Performance Guidelines

16. Security Guidelines

---

# 1. Purpose

This document defines the mandatory coding standards for the Discipline OS project.

Goals

- Maintainability
- Scalability
- Readability
- Testability
- Security
- Performance

---

# 2. General Principles

Every piece of code must be

- Readable
- Reusable
- Testable
- Modular
- Predictable

Avoid

- Duplicate logic
- Hardcoded values
- Large functions
- God classes
- Tight coupling

---

# 3. SOLID Principles

## Single Responsibility

One class → One responsibility.

---

## Open/Closed

Open for extension.

Closed for modification.

---

## Liskov Substitution

Interfaces must be replaceable without changing behavior.

---

## Interface Segregation

Prefer small interfaces.

---

## Dependency Inversion

Depend on abstractions.

Never concrete implementations.

---

# 4. Clean Code Rules

Functions

- Maximum ~40 lines (preferred)
- One responsibility
- Descriptive names
- No hidden side effects

Variables

- Meaningful names
- No abbreviations unless common

Comments

- Explain "why"
- Avoid explaining obvious code

Formatting

- Consistent indentation
- Blank lines between logical blocks
- Max line length configurable

---

# 5. Architecture Rules

Presentation Layer

- UI only
- No business logic

Domain Layer

- Business rules
- Use cases
- Entities

Data Layer

- API
- Database
- Repository implementations

Core Layer

- Shared utilities
- Configuration
- Services

---

# 6. State Management

Framework

Riverpod

Rules

- Immutable state
- AsyncValue for async operations
- Separate UI state from business state
- Dispose resources properly
- Keep providers focused

---

# 7. Dependency Injection

Preferred

Constructor Injection

Service Locator only where justified.

Dependencies should be registered centrally.

Never instantiate repositories inside widgets.

---

# 8. Error Handling

Use custom exceptions.

Examples

- NetworkException
- ValidationException
- AuthException
- AIException
- StorageException

Rules

- Never swallow exceptions
- Show user-friendly messages
- Log technical details separately

---

# 9. Logging Standards

Levels

- Debug
- Info
- Warning
- Error
- Critical

Rules

- No API keys
- No passwords
- No JWT tokens
- No personal health data

Structured logging format

```text
Timestamp
Module
Action
Status
Message
```

---

# 10. Git Workflow

Branches

- main
- develop
- feature/*
- bugfix/*
- hotfix/*
- release/*

Merge Strategy

- Pull Request required
- Code review required
- CI must pass

---

# 11. Commit Convention

Format

```text
type(scope): short description
```

Examples

```text
feat(tasks): add recurring task support

fix(auth): resolve session refresh issue

refactor(ai): simplify provider routing

docs(srs): update API contract

test(focus): add integration tests
```

Types

- feat
- fix
- refactor
- docs
- style
- perf
- test
- chore
- ci

---

# 12. Code Review Checklist

Architecture

- Follows Clean Architecture
- SOLID respected
- No duplicated logic

Code Quality

- Readable
- Proper naming
- Small methods

Security

- Secrets not exposed
- Input validated
- Authorization respected

Performance

- No unnecessary rebuilds
- Efficient queries
- Proper caching

Testing

- Unit tests updated
- Integration tests updated

---

# 13. Testing Standards

Coverage Targets

- Domain Layer ≥ 90%
- Repository Layer ≥ 80%
- UI ≥ 70%

Required Tests

- Unit
- Widget
- Integration
- End-to-End

Mock external dependencies.

---

# 14. Documentation Standards

Every public class should include DartDoc.

Each feature should contain

- README
- Architecture notes
- Usage examples

Maintain changelog for major releases.

---

# 15. Performance Guidelines

- Prefer const widgets
- Minimize widget rebuilds
- Lazy load large lists
- Paginate remote data
- Cache network images
- Optimize database queries
- Compress uploaded images
- Avoid blocking the UI thread

---

# 16. Security Guidelines

- Load secrets from `.env`
- Validate all external input
- Use HTTPS only
- Encrypt sensitive local storage
- Enforce Row Level Security
- Sanitize AI-generated actions
- Never trust client input
- Rotate credentials when necessary

---

# Development Standards Summary

Architecture

- Clean Architecture
- Feature-first
- Repository Pattern
- Dependency Injection

Flutter

- Riverpod
- GoRouter
- Material 3

Backend

- Supabase
- PostgreSQL
- Edge Functions

AI

- Provider abstraction
- JSON responses
- Runtime provider switching

Quality

- Unit-tested
- Documented
- Production-ready
- Scalable
- Secure by default

---

# End of 17_Coding_Standards.md

Next Document:

**18_Testing_QA_Strategy.md**

Contents:
- Testing architecture
- Unit testing plan
- Widget testing
- Integration testing
- End-to-end testing
- Performance testing
- Security testing
- AI testing strategy
- Native Android testing
- QA checklist
- Release acceptance criteria