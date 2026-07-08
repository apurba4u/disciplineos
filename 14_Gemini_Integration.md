# Discipline OS

# 14_Gemini_Integration.md

Version: 1.0

Status: Approved

Document Type:
Gemini AI Integration Specification

---

# Table of Contents

1. Overview

2. Objectives

3. Architecture

4. Model Selection

5. Prompt Engineering

6. Context Management

7. JSON Response Format

8. Streaming Responses

9. Vision Integration

10. AI Function Calling

11. Error Handling

12. Retry Strategy

13. Token Optimization

14. Cost Optimization

15. Safety & Validation

16. Production Checklist

---

# 1. Overview

Gemini is the primary AI provider for Discipline OS.

Responsibilities

- AI Coach
- Daily Planner
- Habit Analysis
- Goal Planning
- Productivity Analysis
- Weekly Reports
- Monthly Reports
- Vision-based Proof Verification

---

# 2. Objectives

Gemini should

- Understand user context
- Return structured JSON
- Avoid hallucinations
- Explain recommendations
- Support streaming
- Support multimodal inputs

---

# 3. Architecture

```
Flutter

↓

Repository

↓

Supabase Edge Function

↓

Gemini API

↓

JSON Response

↓

Response Validator

↓

Database Update

↓

UI Refresh
```

---

# 4. Model Selection

Recommended

- Gemini Flash → Fast interactions
- Gemini Pro → Complex reasoning

Suggested Routing

| Task | Model |
|------|-------|
| Chat | Flash |
| Planning | Pro |
| Weekly Report | Pro |
| Proof Verification | Vision-capable model |
| Productivity Analysis | Pro |

---

# 5. Prompt Engineering

Prompt Structure

```
System Prompt

+

User Profile

+

Current Context

+

User Request

+

Output Schema
```

System Prompt Example

```
You are an AI Discipline Coach.

Always respond using valid JSON.

Never invent user data.

Use available context only.

Provide actionable recommendations.
```

---

# 6. Context Management

Include

- Profile
- Tasks
- Habits
- Goals
- Calendar
- Focus
- Sleep
- Water
- Mood
- Screen Time

Exclude

- Secrets
- API Keys
- Deleted Records
- Unrelated History

---

# 7. JSON Response Format

```json
{
  "status":"success",
  "summary":"Today's plan generated.",
  "confidence":0.95,
  "recommendations":[
    "Complete your high-priority task first."
  ],
  "actions":[
    {
      "type":"create_focus_session",
      "duration":50
    }
  ]
}
```

Never rely on plain text for actionable operations.

---

# 8. Streaming Responses

Support

- Token streaming
- Partial rendering
- Cancel generation
- Retry generation

UI Requirements

- Typing indicator
- Stop button
- Regenerate button
- Copy button
- Markdown rendering

---

# 9. Vision Integration

Supported Inputs

- Camera photo
- Screenshot
- Gallery image

Workflow

```
Image

↓

Compression

↓

Upload

↓

Gemini Vision

↓

Confidence Score

↓

Structured JSON
```

Expected Output

```json
{
  "verified":true,
  "confidence":93,
  "reason":"Open textbook with highlighted pages detected."
}
```

---

# 10. AI Function Calling

Supported Functions

- create_task
- update_task
- create_habit
- create_goal
- schedule_event
- start_focus
- generate_report
- verify_proof

Workflow

```
Gemini Response

↓

Action Validator

↓

Repository

↓

Database

↓

Realtime Update
```

Never execute destructive actions without user confirmation.

---

# 11. Error Handling

Possible Errors

- Timeout
- Invalid JSON
- Network Failure
- API Limit
- Empty Response

Recovery

- Retry once
- Switch provider (optional)
- Use cached insights
- Inform user gracefully

---

# 12. Retry Strategy

| Error | Retry |
|--------|------:|
| Timeout | 1 |
| Rate Limit | Exponential Backoff |
| Invalid JSON | Ask model to repair |
| Network Error | Retry after reconnect |

---

# 13. Token Optimization

- Send only relevant context
- Summarize long history
- Remove duplicate data
- Compress analytics
- Limit prompt size

---

# 14. Cost Optimization

- Use Flash for routine requests
- Cache repeated summaries
- Batch report generation
- Avoid unnecessary AI calls
- Compress images before upload
- Skip AI for deterministic calculations

---

# 15. Safety & Validation

Rules

- Validate JSON before parsing
- Reject malformed responses
- Never expose API keys
- Never trust model output blindly
- Validate all AI-generated actions
- Log AI failures for debugging

---

# 16. Production Checklist

- Gemini API key stored in `.env`
- Streaming tested
- Vision tested
- JSON schema validation enabled
- Timeout configured
- Retry policy implemented
- Token usage monitoring enabled
- Cost monitoring enabled
- Prompt versioning enabled
- AI logs stored securely

---

# Gemini Integration Standards

- Provider abstraction layer
- Structured JSON responses
- Streaming-first UX
- Vision support
- Tool/function calling
- Secure Edge Function proxy
- Runtime model switching
- Production-ready monitoring

---

# End of 14_Gemini_Integration.md

Next Document:

**15_DeepSeek_Integration.md**

Contents:
- DeepSeek architecture
- Provider abstraction
- Reasoning model integration
- JSON output contracts
- Fallback routing
- Streaming
- Prompt templates
- Error handling
- Performance tuning
- Cost optimization