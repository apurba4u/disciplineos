# Discipline OS

# 16_Folder_Structure.md

Version: 1.0

Status: Approved

Document Type:
Flutter Project Folder Structure

---

# Table of Contents

1. Project Structure

2. Feature-First Architecture

3. Core Module

4. Shared Module

5. Features

6. Native Android

7. Assets

8. Environment Configuration

9. Build Flavors

10. Naming Conventions

11. Coding Standards

---

# 1. Project Structure

```
discipline_os/

android/

ios/

web/

linux/

macos/

windows/

assets/

lib/

test/

integration_test/

docs/

scripts/

.env.dev

.env.staging

.env.production

pubspec.yaml

README.md
```

---

# 2. Feature-First Architecture

```
lib/

core/

shared/

features/

main.dart

bootstrap.dart
```

Every feature is independent.

---

# 3. Core Module

```
core/

config/

constants/

errors/

exceptions/

extensions/

helpers/

logger/

network/

permissions/

router/

security/

services/

storage/

theme/

utils/

widgets/
```

Responsibilities

- App configuration
- Dependency Injection
- Logging
- Routing
- Secure Storage
- Theme
- Network Layer

---

# 4. Shared Module

```
shared/

components/

dialogs/

models/

widgets/

mixins/

enums/

validators/

```

Purpose

Reusable components across all features.

---

# 5. Features

```
features/

auth/

dashboard/

tasks/

habits/

goals/

calendar/

focus/

analytics/

health/

notifications/

profile/

settings/

ai/

social/

gamification/

screen_time/

proof/

```

Every feature contains

```
feature/

data/

datasources/

models/

repositories/

domain/

entities/

repositories/

usecases/

presentation/

pages/

widgets/

controllers/

providers/

```

---

## Example

```
features/tasks/

data/

datasources/

task_remote_datasource.dart

task_local_datasource.dart

models/

task_model.dart

repository/

task_repository_impl.dart

domain/

entities/

task.dart

repositories/

task_repository.dart

usecases/

create_task.dart

update_task.dart

delete_task.dart

presentation/

pages/

task_page.dart

create_task_page.dart

widgets/

task_card.dart

task_tile.dart

controllers/

task_controller.dart

providers/

task_provider.dart
```

---

# 6. Native Android

```
android/app/src/main/kotlin/

bridge/

usage/

focus/

health/

notifications/

permissions/

battery/

boot/

workers/

```

MethodChannels

```
NativeBridge.kt

UsageModule.kt

FocusLockModule.kt

HealthModule.kt

```

---

# 7. Assets

```
assets/

fonts/

icons/

images/

illustrations/

animations/

lottie/

sounds/

translations/

themes/
```

---

# 8. Environment Configuration

```
.env.dev

.env.staging

.env.production
```

Variables

```env
SUPABASE_URL=

SUPABASE_ANON_KEY=

GEMINI_API_KEY=

DEEPSEEK_API_KEY=

GOOGLE_API_KEY=

GOOGLE_CLIENT_ID=
```

Never commit environment files.

---

# 9. Build Flavors

Development

```
com.discipline.dev
```

Staging

```
com.discipline.staging
```

Production

```
com.discipline.app
```

Each flavor should have

- Separate icons
- Separate Firebase config
- Separate Supabase backend
- Separate `.env`

---

# 10. Naming Conventions

Files

```
snake_case.dart
```

Classes

```
PascalCase
```

Variables

```
camelCase
```

Constants

```
UPPER_SNAKE_CASE
```

Folders

```
snake_case
```

Use Cases

```
create_task.dart

update_task.dart

generate_daily_plan.dart
```

---

# 11. Coding Standards

Architecture

- Clean Architecture
- SOLID
- DRY
- Repository Pattern
- Dependency Injection
- Feature-first

State Management

- Riverpod only

Navigation

- GoRouter

Networking

- Dio

Local Database

- Drift or Isar

Secure Storage

- flutter_secure_storage

Linting

- flutter_lints
- custom_analysis_options.yaml

Testing

- Unit Tests
- Widget Tests
- Integration Tests

Documentation

- DartDoc comments for public APIs
- README for every major module

Logging

- Structured logging
- No sensitive information in logs

---

# Recommended Dependency Categories

Core

- flutter_riverpod
- go_router
- dio
- freezed
- json_serializable

Backend

- supabase_flutter

AI

- Custom AI provider layer
- HTTP client

Native

- MethodChannel bridge

Utilities

- intl
- uuid
- logger
- connectivity_plus

Testing

- flutter_test
- mocktail
- integration_test

---

# Folder Structure Principles

- One responsibility per folder
- No circular dependencies
- Features communicate through interfaces
- Business logic stays in domain layer
- UI contains no business logic
- Native code isolated from Flutter UI
- AI providers hidden behind abstraction

---

# End of 16_Folder_Structure.md

Next Document:

**17_Coding_Standards.md**

Contents:
- SOLID principles
- Clean Code guidelines
- Error handling conventions
- Logging standards
- Dependency Injection
- Riverpod patterns
- Repository implementation rules
- Git workflow
- Commit conventions
- Code review checklist