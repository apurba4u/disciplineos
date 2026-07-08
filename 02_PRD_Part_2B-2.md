# Discipline OS

# Product Requirements Document (PRD)

## Part 2B-2

Version: 1.0

Status: Approved

---

# Table of Contents

32. Step Counter

33. Sleep Tracking

34. Water Tracking

35. Workout Tracking

36. Mood Tracking

37. Gamification

38. Social Accountability

39. Supabase Functional Requirements

40. AI Scoring Engine

41. Edge Cases

42. Acceptance Criteria

---

# 32. Step Counter

## Purpose

Automatically monitor users' daily physical activity.

---

## Native Requirements

Health Connect

Android Step Counter Sensor

MethodChannel

Kotlin

---

## Features

Today's Steps

Weekly Steps

Monthly Steps

Calories Burned (Estimated)

Distance

Active Minutes

Daily Goal

Weekly Goal

Monthly Goal

---

## AI Responsibilities

Detect inactive days.

Recommend walking goals.

Estimate calorie expenditure.

Suggest better activity schedules.

Generate weekly health reports.

---

## Database

step_logs

Fields

id

user_id

steps

distance

calories

goal

date

created_at

---

# 33. Sleep Tracking

## Purpose

Help users improve discipline through better sleep habits.

---

## Data Sources

Health Connect

Manual Entry

Wearables (Future)

---

## Features

Sleep Duration

Sleep Start

Wake Time

Sleep Quality

Sleep Debt

Weekly Average

Monthly Average

---

## AI Analysis

Detect poor sleep patterns.

Recommend bedtime.

Recommend wake time.

Predict burnout risk.

Suggest recovery plans.

---

## Database

sleep_logs

Fields

id

user_id

start_time

end_time

duration

quality

source

date

---

# 34. Water Tracking

## Purpose

Monitor hydration.

---

## Features

Quick Add

250ml

500ml

750ml

1L

Custom Amount

Daily Goal

History

Reminders

Statistics

---

## AI Responsibilities

Suggest water intake.

Adjust recommendations based on

Weather

Workout

Body Weight

Focus Sessions

---

## Database

water_logs

Fields

id

user_id

amount

goal

date

created_at

---

# 35. Workout Tracking

## Features

Workout Name

Duration

Calories

Muscle Group

Notes

Workout History

PR Records

Exercise Library

Gym Attendance

---

## AI Features

Generate workout plans.

Recommend recovery.

Estimate training load.

Analyze consistency.

---

# 36. Mood Tracking

## Purpose

Track emotional state and correlate it with productivity.

---

## Mood Types

Excellent

Good

Neutral

Low

Bad

---

## Inputs

Emoji

Slider

Text Journal

Voice Note

---

## AI Responsibilities

Identify mood patterns.

Correlate mood with

Sleep

Focus

Screen Time

Habits

Recommend improvements.

---

# 37. Gamification

## Purpose

Increase long-term engagement.

---

## XP System

Complete Task

+10 XP

Complete Habit

+5 XP

Focus Session

+20 XP

Workout

+15 XP

Water Goal

+5 XP

Sleep Goal

+15 XP

Weekly Goal

+100 XP

---

## Levels

Level 1

Beginner

Level 10

Consistent

Level 25

Disciplined

Level 50

Elite

Level 100

Master

---

## Achievements

7 Day Streak

30 Day Streak

100 Tasks

100 Habits

100 Focus Sessions

Perfect Week

Perfect Month

No Procrastination Week

---

## Rewards

Badges

Titles

XP

Animated Celebrations

Profile Showcase

---

# 38. Social Accountability

## Purpose

Allow users to stay disciplined together.

---

## Features

Add Friends

Invite Partner

Join Accountability Groups

Weekly Challenges

Monthly Challenges

Leaderboard

Share Progress

Study Together

Focus Together

Workout Together

---

## AI Features

Suggest accountability partners.

Detect inactive groups.

Recommend challenges.

Summarize group performance.

---

## Privacy

Private Profile

Friends Only

Public

Hide Analytics

Hide Goals

Hide Habits

---

# 39. Supabase Functional Requirements

## Authentication

Email

Google

Anonymous (Optional)

Session Management

Refresh Tokens

---

## Database

PostgreSQL

Row Level Security

Indexes

Foreign Keys

Triggers

Views

RPC Functions

---

## Storage

Task Attachments

Images

Proof Photos

Voice Notes

Profile Pictures

---

## Realtime

Task Updates

Habit Updates

Friend Activity

Leaderboard

Notifications

---

## Edge Functions

AI Proxy

Webhook Processing

Scheduled Jobs

Analytics

---

## Backup

Daily Backup

Recovery Support

Export User Data

---

# 40. AI Scoring Engine

## Discipline Score

Calculated from

Task Completion

Habit Completion

Sleep

Water

Focus

Workout

Screen Time

Consistency

Proof Verification

---

## Productivity Score

Based on

Completed Work

Focus Sessions

Deep Work

Distractions

Schedule Adherence

---

## Health Score

Steps

Sleep

Water

Workout

Recovery

---

## Focus Score

Interruptions

Session Length

Completed Sessions

Phone Usage

---

## AI Weekly Summary

Strengths

Weaknesses

Recommendations

Achievements

Improvement Plan

---

## AI Monthly Review

Performance Trend

Goal Completion

Habit Growth

Productivity Analysis

Health Analysis

Suggested Next Month Roadmap

---

# 41. Edge Cases

No Internet

Use local database.

Sync later.

---

Permission Denied

Continue with reduced functionality.

Never crash.

---

AI API Failure

Retry automatically.

Fallback to cached suggestions.

Allow manual operation.

---

Battery Optimization

Warn user.

Guide to disable restrictions.

---

Clock Changes

Recalculate reminders safely.

---

Duplicate Sync

Detect conflicts.

Merge intelligently.

---

Multiple Devices

Last-write conflict resolution.

User confirmation when necessary.

---

# 42. Global Acceptance Criteria

Application startup under 3 seconds.

Offline-first architecture.

Automatic cloud synchronization.

No sensitive data stored insecurely.

Native Android features implemented using Kotlin when Flutter is insufficient.

MethodChannels documented.

All modules integrated through Clean Architecture.

Environment variables loaded from `.env`.

Gemini and DeepSeek switchable at runtime.

Support Material 3.

Support Light, Dark, AMOLED themes.

Support multiple fonts.

Responsive UI.

Production-ready logging.

Comprehensive error handling.

Scalable folder structure.

Unit-test-ready codebase.

No hardcoded secrets.

No placeholder implementations.

All major features documented and maintainable.

---

# End of PRD Part 2B-2

The next document is:

03_SRS.md

This document will define:

- Complete functional specifications
- Non-functional requirements
- Module interactions
- Sequence diagrams
- State diagrams
- Data flow
- API contracts
- Validation rules
- Security requirements
- Performance requirements
- Complete system behavior