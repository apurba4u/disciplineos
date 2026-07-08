# Discipline OS

# 05_Database_Design.md

Version: 1.0

Status: Approved

Document Type:
Database Design Specification

---

# Table of Contents

1. Database Overview

2. Design Principles

3. Entity Relationship Overview

4. Core Tables

5. AI Tables

6. Health Tables

7. Productivity Tables

8. Social Tables

9. Storage Buckets

10. Indexing Strategy

11. Row Level Security

12. Database Triggers

13. Views

14. Realtime Channels

15. Migration Strategy

---

# 1. Database Overview

Database Engine

PostgreSQL (Supabase)

Features

- Row Level Security
- Realtime
- Storage
- Triggers
- Views
- Functions
- Edge Functions

---

# 2. Design Principles

Every table must include

```sql
id UUID PRIMARY KEY

user_id UUID

created_at TIMESTAMP

updated_at TIMESTAMP

deleted_at TIMESTAMP NULL

sync_status TEXT

version INTEGER
```

Rules

- UUID everywhere
- Soft delete preferred
- Foreign keys enforced
- Indexed frequently queried columns
- RLS enabled for every user table

---

# 3. Entity Relationship Overview

```
Users
 │
 ├── Tasks
 │     └── Task Proofs
 │
 ├── Habits
 │
 ├── Goals
 │     └── Milestones
 │
 ├── Calendar Events
 │
 ├── Focus Sessions
 │
 ├── AI History
 │
 ├── Notifications
 │
 ├── Water Logs
 │
 ├── Sleep Logs
 │
 ├── Step Logs
 │
 ├── Workout Logs
 │
 ├── Mood Logs
 │
 ├── Screen Time
 │
 ├── App Usage
 │
 ├── Analytics
 │
 ├── Achievements
 │
 └── Settings
```

---

# 4. Core Tables

## users

```sql
id

email

name

photo_url

occupation

timezone

language

created_at

updated_at
```

---

## settings

```sql
id

user_id

theme

font

accent_color

ai_provider

language

notification_enabled

created_at
```

---

## tasks

```sql
id

user_id

title

description

priority

status

deadline

estimated_minutes

actual_minutes

category

proof_required

created_at

updated_at
```

---

## subtasks

```sql
id

task_id

title

completed
```

---

## task_proofs

```sql
id

task_id

image_url

confidence_score

verification_status

ai_reason

created_at
```

---

## habits

```sql
id

user_id

title

category

frequency

target

unit

streak

completion_rate

created_at
```

---

## goals

```sql
id

user_id

title

description

category

target_date

progress

status

created_at
```

---

## milestones

```sql
id

goal_id

title

completed

deadline
```

---

## calendar_events

```sql
id

user_id

title

description

start_time

end_time

event_type

linked_task

linked_goal
```

---

## focus_sessions

```sql
id

user_id

start_time

end_time

duration

interruptions

linked_task

score
```

---

# 5. AI Tables

## ai_history

```sql
id

user_id

provider

prompt

response

tokens_used

latency

created_at
```

---

## ai_reports

```sql
id

user_id

report_type

summary

recommendations

score

created_at
```

Types

- Daily
- Weekly
- Monthly

---

## ai_memory (Future)

```sql
id

user_id

memory_key

memory_value

importance

expires_at
```

---

# 6. Health Tables

## water_logs

```sql
id

user_id

amount_ml

logged_at
```

---

## sleep_logs

```sql
id

user_id

sleep_start

sleep_end

duration

quality
```

---

## step_logs

```sql
id

user_id

steps

distance

calories

logged_at
```

---

## workout_logs

```sql
id

user_id

workout_name

duration

calories

notes
```

---

## mood_logs

```sql
id

user_id

mood

journal

created_at
```

---

# 7. Productivity Tables

## app_usage

```sql
id

user_id

package_name

app_name

duration_seconds

launch_count

date
```

---

## screen_time

```sql
id

user_id

total_minutes

productive_minutes

distracting_minutes

date
```

---

## analytics

```sql
id

user_id

discipline_score

productivity_score

health_score

focus_score

generated_at
```

---

## notifications

```sql
id

user_id

title

body

type

scheduled_at

read
```

---

## achievements

```sql
id

user_id

title

description

xp

earned_at
```

---

# 8. Social Tables

## friends

```sql
id

user_id

friend_id

status
```

Status

Pending

Accepted

Blocked

---

## challenges

```sql
id

title

description

start_date

end_date
```

---

## leaderboard

```sql
id

user_id

xp

rank

season
```

---

# 9. Storage Buckets

```
profile-images/

proof-images/

voice-notes/

task-attachments/

exports/

workout-images/

temporary/
```

---

# 10. Indexing Strategy

Create indexes on

```sql
user_id

created_at

deadline

status

category

date

goal_id

task_id

habit_id
```

Composite Indexes

```sql
(user_id, deadline)

(user_id, status)

(user_id, created_at)
```

---

# 11. Row Level Security

Example Policy

```sql
auth.uid() = user_id
```

Rules

- Users access only their own data.
- Storage protected by ownership.
- Edge Functions use service role only.

---

# 12. Database Triggers

Automatically

- Update `updated_at`
- Calculate streaks
- Update goal progress
- Generate analytics
- Queue notifications
- Log audit events

---

# 13. Views

## dashboard_view

Combines

- Tasks
- Habits
- Goals
- Analytics
- Focus
- Health

---

## weekly_summary_view

Returns

- Completed Tasks
- Completed Habits
- Focus Time
- Average Sleep
- Water Intake
- Discipline Score

---

# 14. Realtime Channels

Subscribe to

```
tasks

habits

goals

notifications

friends

leaderboard

analytics
```

Events

- INSERT
- UPDATE
- DELETE

---

# 15. Migration Strategy

Migration Rules

- Version every migration
- Never edit applied migrations
- Seed demo data separately
- Rollback scripts required
- Test migrations before production

Example

```
001_initial_schema.sql

002_auth.sql

003_tasks.sql

004_habits.sql

005_goals.sql

006_ai.sql

007_health.sql

008_social.sql

009_indexes.sql

010_rls.sql
```

---

# Database Standards

- UUID Primary Keys
- PostgreSQL Best Practices
- Soft Deletes
- Foreign Key Constraints
- Indexed Queries
- Optimistic Sync
- Offline-first Compatibility
- RLS on Every User Table
- Secure Storage Integration
- Migration Version Control

---

# End of 05_Database_Design.md

Next Document:

**06_API_Design.md**

Contents:
- REST API Specification
- Supabase Edge Functions
- AI Gateway Design
- Request/Response Schemas
- Authentication Flow
- Rate Limiting
- Webhooks
- Error Codes
- OpenAPI-style API Contracts