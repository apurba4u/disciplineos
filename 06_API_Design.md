# Discipline OS

# 06_API_Design.md

Version: 1.0

Status: Approved

Document Type:
API Design Specification

---

# Table of Contents

1. API Overview

2. Authentication

3. API Standards

4. Response Format

5. Authentication APIs

6. Task APIs

7. Habit APIs

8. Goal APIs

9. AI APIs

10. Health APIs

11. Analytics APIs

12. Notification APIs

13. Error Handling

14. Rate Limiting

15. Edge Functions

---

# 1. API Overview

Backend

Supabase

API Style

REST + Supabase RPC + Edge Functions

AI

Gemini

DeepSeek

Authentication

JWT Bearer Token

Transport

HTTPS Only

---

# 2. Authentication

Every protected request must contain

```
Authorization: Bearer <JWT_TOKEN>
```

Anonymous requests are not allowed except

- Login
- Register
- Forgot Password

---

# 3. API Standards

Content Type

```
application/json
```

Timezone

UTC

Date Format

ISO-8601

ID Format

UUID

---

# 4. Standard Response Format

## Success

```json
{
  "success": true,
  "message": "Task created",
  "data": {},
  "timestamp": "2026-07-07T10:00:00Z"
}
```

---

## Error

```json
{
  "success": false,
  "code": "TASK_NOT_FOUND",
  "message": "Task not found",
  "details": null
}
```

---

# 5. Authentication APIs

## Register

POST

```
/auth/register
```

Body

```json
{
  "name": "",
  "email": "",
  "password": ""
}
```

---

## Login

POST

```
/auth/login
```

---

## Logout

POST

```
/auth/logout
```

---

## Refresh Token

POST

```
/auth/refresh
```

---

## Forgot Password

POST

```
/auth/forgot-password
```

---

# 6. Task APIs

## Get Tasks

GET

```
/tasks
```

Query

```
?page=

?limit=

?status=

?priority=

?category=
```

---

## Create Task

POST

```
/tasks
```

Body

```json
{
"title":"",

"description":"",

"deadline":"",

"priority":"High"
}
```

---

## Update Task

PUT

```
/tasks/{id}
```

---

## Delete Task

DELETE

```
/tasks/{id}
```

---

## Complete Task

POST

```
/tasks/{id}/complete
```

---

## Upload Proof

POST

```
/tasks/{id}/proof
```

Multipart

Image

---

# 7. Habit APIs

GET

```
/habits
```

POST

```
/habits
```

PUT

```
/habits/{id}
```

DELETE

```
/habits/{id}
```

POST

```
/habits/{id}/complete
```

POST

```
/habits/{id}/pause
```

---

# 8. Goal APIs

GET

```
/goals
```

POST

```
/goals
```

PUT

```
/goals/{id}
```

DELETE

```
/goals/{id}
```

POST

```
/goals/{id}/milestone
```

POST

```
/goals/{id}/progress
```

---

# 9. AI APIs

## Chat

POST

```
/ai/chat
```

```json
{
"provider":"gemini",

"message":"..."
}
```

---

## Generate Daily Plan

POST

```
/ai/daily-plan
```

---

## Weekly Review

POST

```
/ai/weekly-review
```

---

## Monthly Review

POST

```
/ai/monthly-review
```

---

## Verify Proof

POST

```
/ai/verify-proof
```

Input

- Image
- Task Context

Output

```json
{
"confidence":92,

"status":"verified",

"reason":"Likely completed"
}
```

---

## Generate Routine

POST

```
/ai/routine
```

---

## Analyze Productivity

POST

```
/ai/productivity
```

---

# 10. Health APIs

## Water

POST

```
/health/water
```

GET

```
/health/water
```

---

## Sleep

POST

```
/health/sleep
```

GET

```
/health/sleep
```

---

## Steps

GET

```
/health/steps
```

---

## Workout

POST

```
/health/workout
```

---

## Mood

POST

```
/health/mood
```

---

# 11. Analytics APIs

GET

```
/analytics/dashboard
```

GET

```
/analytics/daily
```

GET

```
/analytics/weekly
```

GET

```
/analytics/monthly
```

GET

```
/analytics/yearly
```

---

# 12. Notification APIs

GET

```
/notifications
```

PUT

```
/notifications/read
```

DELETE

```
/notifications/{id}
```

POST

```
/notifications/test
```

---

# 13. Error Codes

```
AUTH_REQUIRED

INVALID_TOKEN

TOKEN_EXPIRED

VALIDATION_ERROR

TASK_NOT_FOUND

HABIT_NOT_FOUND

GOAL_NOT_FOUND

AI_TIMEOUT

AI_PROVIDER_ERROR

NETWORK_ERROR

PERMISSION_DENIED

UPLOAD_FAILED

SYNC_FAILED

DATABASE_ERROR

UNKNOWN_ERROR
```

---

# 14. Rate Limiting

AI Chat

```
60 requests/hour
```

Proof Verification

```
30/day
```

Authentication

```
10 attempts/15 min
```

General APIs

```
120 requests/minute
```

---

# 15. Supabase Edge Functions

## AI Gateway

```
POST

/functions/v1/ai-chat
```

Responsibilities

- Validate JWT
- Read provider
- Build prompt
- Call Gemini/DeepSeek
- Log usage
- Return response

---

## Proof Verification

```
POST

/functions/v1/proof
```

Responsibilities

- Upload validation
- Virus check (future)
- AI Vision
- Store confidence
- Return result

---

## Daily Report Scheduler

Runs automatically.

Responsibilities

- Aggregate data
- Generate AI summary
- Save report
- Schedule notification

---

## Weekly Report Scheduler

Runs every Sunday.

---

## Monthly Report Scheduler

Runs on first day of each month.

---

# API Security

- HTTPS only
- JWT validation on every protected endpoint
- Row Level Security enforced
- Input validation
- Request size limits
- CORS configuration
- Structured audit logs
- Secrets loaded from `.env`
- No direct AI API calls from the client; route through Edge Functions where possible

---

# API Versioning

```
/api/v1/
```

Future

```
/api/v2/
```

Breaking changes require a new API version.

---

# End of 06_API_Design.md

Next Document:

**07_AI_Agent_Architecture.md**

Includes:
- AI Orchestrator
- Prompt Builder
- Context Manager
- Memory Strategy
- Multi-Agent Workflow
- Gemini/DeepSeek Router
- AI Action Execution
- Tool Calling Design
- Prompt Templates
- Token Optimization
- Cost Optimization