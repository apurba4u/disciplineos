# Discipline OS

# 04_System_Architecture.md

Version: 1.0

Status: Approved

Document Type:
System Architecture

---

# Table of Contents

1. High-Level Architecture

2. Layered Architecture

3. Feature Architecture

4. AI Architecture

5. Native Android Architecture

6. Supabase Architecture

7. Offline Architecture

8. Synchronization Engine

9. Background Services

10. MethodChannel Architecture

11. Data Flow

12. Sequence Flows

13. Scalability

---

# 1. High-Level Architecture

```
                    User
                     │
                     ▼
              Flutter UI (Material 3)
                     │
          Riverpod State Management
                     │
             Use Case Layer
                     │
          Repository Abstraction
      ┌──────────┼───────────┐
      ▼          ▼           ▼
 Local DB    Supabase     Native Kotlin
      │          │           │
      └──────────┼───────────┘
                 ▼
            AI Service Layer
         Gemini / DeepSeek
```

---

# 2. Layered Architecture

```
Presentation

↓

Application (Use Cases)

↓

Domain

↓

Repository

↓

Data Sources

↓

Supabase
SQLite/Isar
Native Android
AI Providers
```

Each layer must only communicate with adjacent layers.

---

# 3. Feature Architecture

Every feature follows the same structure.

```
feature/

presentation/

widgets/

pages/

controllers/

domain/

entities/

repositories/

usecases/

data/

models/

datasources/

repository_impl/

```

Examples

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

settings/

ai/

```

---

# 4. AI Architecture

```
User

↓

Prompt Builder

↓

Context Collector

↓

AI Router

↓

Gemini
or
DeepSeek

↓

Response Validator

↓

Action Parser

↓

Database Update

↓

Dashboard Refresh
```

---

## Context Builder

Before sending a prompt, collect:

- User Profile
- Active Goals
- Pending Tasks
- Habit Progress
- Focus History
- Sleep
- Water
- Screen Time
- Calendar Events

Never send unnecessary information.

---

## AI Provider Layer

```
abstract class AIProvider {

chat()

generatePlan()

verifyProof()

summarize()

}
```

Implementations

```
GeminiProvider

DeepSeekProvider
```

Switch providers without changing business logic.

---

# 5. Native Android Architecture

Flutter handles UI and business logic.

Native Kotlin handles platform APIs.

```
Flutter

↓

MethodChannel

↓

Kotlin

↓

Android SDK

↓

UsageStats

Accessibility

Health Connect

AlarmManager

Foreground Services

```

---

## Native Modules

UsageStatsModule

AccessibilityModule

HealthModule

NotificationModule

BatteryModule

PermissionModule

ForegroundServiceModule

BootReceiverModule

---

# 6. Supabase Architecture

```
Flutter

↓

Supabase Auth

↓

PostgreSQL

↓

Storage

↓

Realtime

↓

Edge Functions
```

---

## Tables

users

tasks

habits

goals

focus_sessions

calendar_events

notifications

water_logs

sleep_logs

step_logs

workouts

proofs

app_usage

screen_time

settings

ai_history

analytics

achievements

friends

leaderboard

---

## Storage Buckets

profile-images

proof-images

voice-notes

attachments

exports

---

# 7. Offline Architecture

```
Flutter

↓

Local Database

↓

Pending Sync Queue

↓

Internet Available

↓

Supabase

↓

Queue Cleared
```

Offline-first is mandatory.

---

## Local Cache

Tasks

Habits

Goals

Calendar

Settings

Analytics

AI History (optional)

---

# 8. Synchronization Engine

Each local change receives:

```
record_id

version

updated_at

sync_status
```

---

## Sync Strategy

Create

Update

Delete

Retry Failed

Resolve Conflict

---

## Conflict Resolution

Latest timestamp wins by default.

If both devices modified the same record:

Ask user or merge where possible.

---

# 9. Background Services

Background jobs include:

- Notification Scheduler
- Habit Reminder
- Sync Engine
- Upload Queue
- Analytics Refresh
- Daily AI Summary
- Weekly Report Generation

Use:

- WorkManager
- Foreground Service
- AlarmManager (when appropriate)

---

# 10. MethodChannel Architecture

```
Flutter

↓

NativeBridge

↓

MethodChannel

↓

Android Kotlin

↓

Platform API
```

Methods

```
getUsageStats()

startFocusLock()

stopFocusLock()

getSteps()

getSleep()

requestPermissions()

scheduleAlarm()

```

---

# 11. Data Flow

## Task Creation

```
User

↓

Task Form

↓

Validation

↓

Repository

↓

Local Save

↓

Background Sync

↓

Supabase

↓

Dashboard Update

```

---

## AI Chat

```
User Prompt

↓

Prompt Builder

↓

AI Provider

↓

Response

↓

Save History

↓

Display

```

---

## Camera Proof

```
Capture Image

↓

Compress

↓

Upload Storage

↓

Gemini Vision

↓

Verification

↓

Database

↓

Task Completed

```

---

# 12. Sequence Flow

## Login

```
User

↓

Flutter

↓

Supabase Auth

↓

JWT

↓

Dashboard
```

---

## Focus Session

```
Start

↓

Foreground Service

↓

Timer

↓

Accessibility Lock

↓

Session Complete

↓

Analytics

↓

AI Summary

```

---

## Daily AI Review

```
Scheduler

↓

Collect User Data

↓

Generate Prompt

↓

Gemini/DeepSeek

↓

Save Summary

↓

Notification

```

---

# 13. Scalability

Future-ready architecture must support:

- Web
- Desktop
- iOS
- Wear OS
- AI Memory
- AI Agents
- MCP Servers
- Plugin Marketplace
- Team Collaboration
- Enterprise Mode

---

# Architecture Principles

- Clean Architecture
- SOLID
- DRY
- Feature-first
- Offline-first
- AI-first
- Repository Pattern
- Dependency Injection
- Native abstraction via MethodChannels
- Environment-based configuration
- Secure by default
- Scalable without major refactoring

---

# End of 04_System_Architecture.md

Next Document:

**05_Database_Design.md**

Includes:
- Complete ER Model
- 20+ Table Schemas
- Relationships
- Indexes
- RLS Policies
- Triggers
- Views
- Storage Structure
- Realtime Channels
- Migration Strategy