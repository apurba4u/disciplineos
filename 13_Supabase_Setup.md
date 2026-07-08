# Discipline OS

# 13_Supabase_Setup.md

Version: 1.0

Status: Approved

Document Type:
Supabase Backend Setup Specification

---

# Table of Contents

1. Overview

2. Project Configuration

3. Authentication

4. Database

5. Row Level Security (RLS)

6. Storage

7. Realtime

8. Edge Functions

9. Database Functions & Triggers

10. Backup Strategy

11. Environment Configuration

12. Production Checklist

---

# 1. Overview

Supabase is the primary backend platform for Discipline OS.

Services Used

- Authentication
- PostgreSQL Database
- Storage
- Realtime
- Edge Functions
- Scheduled Jobs
- Logs

---

# 2. Project Configuration

Project Name

```
discipline-os
```

Regions

- Development
- Staging
- Production

Each environment must use a separate Supabase project.

---

# 3. Authentication

Supported Providers

- Email/Password
- Google OAuth

Future

- Apple
- GitHub
- Microsoft

Requirements

- Email verification
- Password reset
- JWT sessions
- Refresh tokens
- Secure logout
- Session persistence

---

# 4. Database

Core Tables

- users
- settings
- tasks
- subtasks
- habits
- goals
- milestones
- calendar_events
- focus_sessions
- task_proofs
- ai_history
- ai_reports
- notifications
- water_logs
- sleep_logs
- step_logs
- workout_logs
- mood_logs
- app_usage
- screen_time
- analytics
- achievements
- friends

Rules

- UUID primary keys
- Foreign keys
- Soft delete
- Automatic timestamps
- Indexed query fields

---

# 5. Row Level Security (RLS)

Enable RLS on every user-owned table.

Example Policy

```sql
create policy "Users can access only their own rows"

on tasks

for all

using (auth.uid() = user_id)

with check (auth.uid() = user_id);
```

Rules

- No cross-user access
- Storage protected by ownership
- Service Role only for trusted server-side operations

---

# 6. Storage

Buckets

```
profile-images

proof-images

voice-notes

attachments

exports

workout-images
```

Rules

- Private by default
- Signed URLs for temporary access
- File validation before upload
- Maximum upload size configurable

---

# 7. Realtime

Enable realtime for

- tasks
- habits
- goals
- notifications
- analytics
- calendar_events

Events

- INSERT
- UPDATE
- DELETE

Use Cases

- Dashboard refresh
- Live notifications
- Multi-device sync

---

# 8. Edge Functions

Functions

## ai-chat

Responsibilities

- Validate JWT
- Build AI context
- Route to Gemini/DeepSeek
- Log usage

---

## verify-proof

Responsibilities

- Validate upload
- Call Vision model
- Save confidence score

---

## weekly-report

Runs on schedule.

- Aggregate analytics
- Generate AI report
- Store summary

---

## monthly-report

Runs monthly.

- Build performance report
- Save report
- Queue notification

---

# 9. Database Functions & Triggers

Functions

- update_updated_at()
- calculate_streak()
- update_goal_progress()
- refresh_dashboard_metrics()
- generate_notification()

Triggers

- Before Update → updated_at
- Habit Complete → streak update
- Goal Progress → analytics refresh
- Task Complete → dashboard refresh

---

# 10. Backup Strategy

Database

- Daily automatic backup
- Weekly full backup
- Point-in-time recovery (if available)

Storage

- Scheduled export
- Retention policy

Recovery

- Test restore procedures regularly

---

# 11. Environment Configuration

`.env`

```env
SUPABASE_URL=

SUPABASE_ANON_KEY=

SUPABASE_SERVICE_ROLE_KEY=

GEMINI_API_KEY=

DEEPSEEK_API_KEY=

GOOGLE_API_KEY=
```

Rules

- Never commit `.env`
- Use separate values for each environment
- Rotate compromised keys immediately

---

# 12. Production Checklist

- Supabase project created
- Authentication configured
- Google OAuth connected
- RLS enabled on all tables
- Storage buckets created
- Edge Functions deployed
- Database migrations applied
- Indexes verified
- Realtime enabled
- Secrets configured
- Backup enabled
- Monitoring enabled
- Logs reviewed
- Production data seeded (if required)

---

# Backend Standards

- PostgreSQL best practices
- Offline-first synchronization
- Secure by default
- Modular schema
- Environment-based configuration
- Migration-driven development
- No hardcoded secrets
- Fully compatible with Clean Architecture

---

# End of 13_Supabase_Setup.md

Next Document:

**14_Gemini_Integration.md**

Contents:
- Gemini API architecture
- Prompt engineering
- Structured JSON output
- Streaming responses
- Vision integration
- Function/tool calling
- Error handling
- Retry strategy
- Cost optimization
- Safety guardrails
- AI response validation