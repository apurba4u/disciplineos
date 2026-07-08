# Discipline OS

# Product Requirements Document (PRD)

## Part 2B-1

Version: 1.0

Status: Approved

---

# Table of Contents

26. AI Camera Proof Verification

27. App Usage Tracking

28. Screen Time Analysis

29. Focus App Lock

30. Native Android Requirements

31. Android Permissions Matrix

---

# 26. AI Camera Proof Verification

## Purpose

Verify whether a user has genuinely completed a task by analyzing uploaded photos or screenshots using Gemini Vision or DeepSeek Vision.

The system should not rely on simple image uploads. Instead, AI must estimate completion confidence.

---

## Objectives

- Increase accountability.
- Reduce fake task completion.
- Build trust in analytics.
- Provide AI-generated feedback.

---

## Supported Proof Types

- Camera Photo
- Gallery Image
- Screenshot
- PDF Screenshot (future)
- Multiple Images

---

## Workflow

Task Created

↓

User clicks **Complete with Proof**

↓

Capture Image / Select Image

↓

Compress image

↓

Upload to Supabase Storage

↓

Send image URL (or bytes) + task context to AI

↓

AI analyzes evidence

↓

Return:

- Confidence Score
- Reasoning
- Suggestions

↓

Store result in database

---

## AI Prompt Responsibilities

AI receives:

- Task title
- Task description
- Due time
- Uploaded image
- Optional notes

AI should answer:

- Does the image likely match the task?
- Confidence (0–100)
- Short explanation
- Suggestions if uncertain

---

## Database Fields

proof_id

task_id

user_id

storage_path

image_url

ai_provider

confidence_score

verification_status

reasoning

created_at

---

## Acceptance Criteria

- Upload < 5 MB
- Compression before upload
- AI response within 10 seconds
- Retry on failure
- Multiple proof uploads supported

---

# 27. App Usage Tracking

## Purpose

Measure how users spend time across installed applications to help AI detect distractions.

---

## Native Android Requirement

Use:

UsageStatsManager

PackageManager

AppOpsManager

Native Kotlin

Flutter MethodChannel

---

## Data Collection

Collect:

- Package Name
- App Name
- Start Time
- End Time
- Usage Duration
- Launch Count
- Foreground Time
- Last Used

---

## Categories

Productivity

Education

Entertainment

Gaming

Social Media

Communication

Finance

Shopping

Utilities

Health

Others

---

## Dashboard Metrics

Today's Usage

Weekly Usage

Monthly Usage

Top 10 Apps

Most Distracting Apps

Most Productive Apps

Average Daily Screen Time

---

## AI Responsibilities

Detect distraction patterns.

Recommend usage limits.

Suggest focus hours.

Warn excessive social media use.

Generate weekly usage summary.

---

## Database

app_usage

Fields

id

user_id

package_name

app_name

category

duration_seconds

launch_count

date

created_at

---

## Acceptance Criteria

Works without root.

Permission validation.

Automatic daily synchronization.

Offline storage.

---

# 28. Screen Time Analysis

## Purpose

Measure total device usage and convert raw statistics into meaningful behavioral insights.

---

## Inputs

App Usage

Focus Sessions

Sleep

Calendar

Tasks

Habits

---

## Outputs

Daily Screen Time

Weekly Trend

Monthly Trend

Average Usage

Peak Usage Hour

Productivity Ratio

Distraction Ratio

---

## AI Analysis

Examples

"You spend 3.8 hours daily on social media."

"Most distractions occur between 9 PM and 11 PM."

"Moving your study session to the morning may improve consistency."

---

## Charts

Line Chart

Bar Chart

Pie Chart

Heat Map

Weekly Comparison

Monthly Comparison

---

## Acceptance Criteria

Automatic updates.

Offline support.

Cloud synchronization.

---

# 29. Focus App Lock

## Purpose

Prevent users from opening distracting applications during focus sessions.

---

## Native Android Requirement

Accessibility Service

Foreground Service

Overlay Permission

MethodChannel

Kotlin

---

## Features

Block selected apps

Temporary lock

Focus whitelist

Emergency exit

Countdown unlock

Automatic unlock

Custom schedules

---

## Workflow

User starts Focus Mode

↓

Accessibility Service activated

↓

Blocked application opened

↓

Intercept launch

↓

Show custom blocking screen

↓

Display:

Remaining focus time

Motivational quote

Resume button disabled

Emergency exit

---

## AI Features

Suggest apps to block.

Recommend focus duration.

Detect repeated interruptions.

Generate distraction report.

---

## Acceptance Criteria

Works without root.

Minimal battery usage.

Automatic disable after focus session.

---

# 30. Native Android Requirements

The application must implement native Android modules whenever Flutter plugins are insufficient.

Required Native Modules

- UsageStatsManager
- AccessibilityService
- Health Connect integration
- Foreground Services
- AlarmManager
- WorkManager
- Notification Channels
- App Shortcuts
- Background Tasks
- Boot Receiver
- Battery Optimization Handling

---

## Flutter Integration

All native functionality must be exposed through MethodChannels.

Avoid duplicate business logic.

Maintain clean separation between Flutter and native code.

---

## Error Handling

Handle

Permission denied

Service unavailable

Device incompatibility

Manufacturer restrictions

Battery optimization

App killed by system

---

# 31. Android Permissions Matrix

## Runtime Permissions

Camera

Microphone

Notifications

Storage / Photos

Activity Recognition

Exact Alarm (where required)

---

## Special Permissions

Usage Access

Accessibility Service

Ignore Battery Optimization

Overlay Permission

Foreground Service

Schedule Exact Alarm

---

## Permission Flow

Request only when needed.

Explain why the permission is required.

Handle denial gracefully.

Allow users to retry later.

Never block the application because of a denied optional permission.

---

## Security Principles

- Minimum permissions first.
- Request incrementally.
- Never collect unnecessary data.
- Respect user privacy.
- Allow complete data deletion.
- Follow Google Play policies.

---

# End of PRD Part 2B-1