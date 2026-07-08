# Discipline OS

# 12_Google_Cloud_Setup.md

Version: 1.0

Status: Approved

Document Type:
Google Cloud Integration Specification

---

# Table of Contents

1. Overview

2. Google Cloud Project

3. APIs to Enable

4. OAuth Configuration

5. Google Sign-In

6. Google Calendar API

7. Firebase Cloud Messaging

8. Health Connect

9. SHA Certificates

10. API Key Security

11. Environment Variables

12. Production Checklist

---

# 1. Overview

Google Cloud provides external services required by Discipline OS.

Services include

- Google Sign-In
- Calendar Sync
- Firebase Cloud Messaging (FCM)
- OAuth Authentication
- Health Connect Integration
- Play Integrity (Future)

---

# 2. Google Cloud Project

Create a dedicated project.

Example

```
Project Name

Discipline OS

Project ID

discipline-os-prod
```

Enable Billing only if required by selected APIs.

Separate projects for

- Development
- Staging
- Production

---

# 3. APIs to Enable

Required APIs

- Google Calendar API
- Google People API
- Identity Toolkit API
- OAuth Consent API
- Firebase Cloud Messaging
- Cloud Resource Manager API

Optional APIs

- Google Drive API
- Gmail API
- Tasks API
- Fit API (legacy where applicable)

---

# 4. OAuth Configuration

Create OAuth Client

Platform

Android

Configure

Package Name

SHA-1

SHA-256

Authorized Redirect URI (if needed)

OAuth Consent Screen

- App Name
- Support Email
- Privacy Policy
- Terms of Service
- Logo
- Developer Contact

---

# 5. Google Sign-In

## Flow

```
User

↓

Google Sign-In

↓

OAuth Token

↓

Supabase Auth

↓

JWT Session

↓

Dashboard
```

---

## Required Scopes

openid

email

profile

Additional scopes only when needed.

---

## Functional Requirements

- Silent Sign-In
- Logout
- Account Switching
- Token Refresh
- Session Recovery

---

# 6. Google Calendar API

Purpose

Synchronize calendar events.

Supported Operations

- Read Events
- Create Events
- Update Events
- Delete Events

Sync Strategy

One-way (MVP)

Two-way (Future)

Conflict Resolution

- Prefer latest timestamp
- Preserve user edits

---

# 7. Firebase Cloud Messaging (FCM)

Notification Types

- Task Reminder
- Habit Reminder
- AI Summary
- Weekly Report
- Monthly Review
- Focus Reminder

Token Lifecycle

Generate

↓

Store in Supabase

↓

Refresh

↓

Invalidate on Logout

---

# 8. Health Connect

Permissions

- Steps
- Sleep
- Exercise
- Weight

Fallback

Manual logging if unavailable.

Sync Modes

- Manual
- Automatic
- Background

---

# 9. SHA Certificates

Configure

Development SHA-1

Development SHA-256

Release SHA-1

Release SHA-256

Verify before release build.

---

# 10. API Key Security

Rules

- Restrict by package name
- Restrict by SHA fingerprint
- Disable unused APIs
- Rotate keys periodically
- Never expose unrestricted keys

Do not hardcode API keys.

---

# 11. Environment Variables

All secrets must be loaded from `.env`.

Example

```env
SUPABASE_URL=

SUPABASE_ANON_KEY=

GEMINI_API_KEY=

DEEPSEEK_API_KEY=

GOOGLE_WEB_CLIENT_ID=

GOOGLE_ANDROID_CLIENT_ID=

GOOGLE_API_KEY=

FCM_SERVER_KEY=
```

Environment files

```
.env.dev

.env.staging

.env.production
```

---

# 12. Production Checklist

- Google Cloud project created
- OAuth consent configured
- Calendar API enabled
- Google Sign-In tested
- SHA-1 & SHA-256 verified
- API keys restricted
- `.env` configured
- FCM working
- Health Connect tested
- Privacy Policy published
- Terms of Service published
- Release build verified

---

# Security Best Practices

- Never commit `.env` to Git.
- Use least-privilege OAuth scopes.
- Validate Google ID tokens on the backend.
- Store tokens securely.
- Refresh expired tokens automatically.
- Log authentication failures without exposing sensitive data.

---

# End of 12_Google_Cloud_Setup.md

Next Document:

**13_Supabase_Setup.md**

Contents:
- Supabase project configuration
- Authentication setup
- PostgreSQL schema
- Row Level Security (RLS)
- Storage buckets
- Realtime configuration
- Edge Functions
- Database triggers
- Backup strategy
- Environment configuration
- Production deployment checklist