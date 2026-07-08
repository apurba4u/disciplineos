# Discipline OS

# 09_Screens_and_User_Flow.md

Version: 1.0

Status: Approved

Document Type:
Screen Specification & User Flow

---

# Table of Contents

1. Navigation Structure
2. Authentication Flow
3. Onboarding Flow
4. Main Navigation
5. Dashboard Flow
6. Screen Catalog
7. AI User Flow
8. Deep Linking
9. Global Navigation Rules

---

# 1. Navigation Structure

```
Splash
   │
Authentication
   │
Onboarding
   │
Home Dashboard
   │
 ┌──────────────┬─────────────┬──────────────┬──────────────┐
 ▼              ▼             ▼              ▼
Tasks         AI Coach     Analytics      Profile
 │              │             │              │
 ▼              ▼             ▼              ▼
Details      Conversation   Reports      Settings
```

---

# 2. Authentication Flow

```
Splash

↓

Check Session

↓

Session Exists?

├── Yes → Dashboard
└── No → Login

↓

Register

↓

Email Verification

↓

Profile Setup

↓

Onboarding

↓

Dashboard
```

---

# 3. Onboarding Flow

### Screen 01 — Welcome

Purpose

Introduce Discipline OS

Actions

- Get Started
- Sign In

---

### Screen 02 — Choose Goals

Options

- Study
- Career
- Health
- Fitness
- Finance
- Business

---

### Screen 03 — Daily Routine

Collect

- Wake Time
- Sleep Time
- Working Hours
- Study Hours

---

### Screen 04 — AI Preferences

Choose

- Gemini
- DeepSeek

AI Personality

- Friendly
- Balanced
- Strict

---

### Screen 05 — Notification Preferences

Configure

- Task reminders
- Habit reminders
- AI reminders

---

### Screen 06 — Permissions

Request

- Notifications
- Camera
- Microphone
- Activity Recognition
- Usage Access
- Accessibility
- Health Connect

---

# 4. Main Navigation

Bottom Navigation

1. Home

2. Tasks

3. AI

4. Analytics

5. Profile

Floating Action Button

Quick Create

- Task
- Habit
- Goal
- Focus Session

---

# 5. Dashboard Flow

Dashboard Widgets

- AI Daily Summary
- Today's Tasks
- Today's Habits
- Goal Progress
- Focus Timer
- Water Intake
- Sleep
- Steps
- Calendar
- Notifications
- Weekly Graph
- Quick Actions

Widget Interaction

Tap → Details

Long Press → Customize

Swipe → Refresh

---

# 6. Screen Catalog

## Authentication

01 Splash

02 Login

03 Register

04 Forgot Password

05 Verify Email

---

## Onboarding

06 Welcome

07 Goals

08 Routine

09 AI Preferences

10 Permissions

---

## Dashboard

11 Home Dashboard

12 Widget Customization

13 AI Daily Summary

14 Quick Actions

---

## Task Module

15 Task List

16 Task Details

17 Create Task

18 Edit Task

19 Subtasks

20 Task Calendar

21 Kanban Board

22 Task Search

23 Task Filter

24 Proof Upload

25 Proof History

---

## Habit Module

26 Habit List

27 Create Habit

28 Habit Details

29 Habit Statistics

30 Habit Calendar

31 Streak History

---

## Goal Module

32 Goal List

33 Goal Details

34 Milestones

35 Goal Roadmap

36 Goal Analytics

---

## AI Module

37 AI Chat

38 AI Planner

39 AI Weekly Review

40 AI Monthly Review

41 AI Productivity Report

42 AI Habit Coach

43 AI Goal Coach

44 AI Health Coach

45 AI Settings

---

## Focus Module

46 Focus Dashboard

47 Pomodoro

48 Deep Work

49 Session History

50 Focus Report

---

## Calendar

51 Daily Calendar

52 Weekly Calendar

53 Monthly Calendar

54 Event Details

55 Create Event

---

## Analytics

56 Dashboard Analytics

57 Productivity

58 Health

59 Focus

60 Discipline Score

61 Weekly Report

62 Monthly Report

---

## Health

63 Water

64 Sleep

65 Steps

66 Workout

67 Mood

68 Weight

---

## Native Features

69 Screen Time

70 App Usage

71 Focus Lock

72 Permissions

73 Device Status

---

## Notifications

74 Notification Center

75 Reminder Settings

---

## Social

76 Friends

77 Accountability Partner

78 Challenges

79 Leaderboard

---

## Settings

80 Profile

81 Appearance

82 Themes

83 Fonts

84 AI Provider

85 Security

86 Backup

87 Privacy

88 About

89 Developer Options

---

## Miscellaneous

90 Search

91 Global Search Results

92 Offline Queue

93 Sync Status

94 Error Screen

95 Empty State

96 Loading State

97 Update Available

98 Feedback

99 Help Center

100 License & Credits

---

# 7. AI User Flow

```
User Question

↓

Collect Context

↓

Build Prompt

↓

AI Provider

↓

Response

↓

Action Suggestions

↓

Optional Tool Execution

↓

Dashboard Update
```

---

# 8. Deep Linking

Supported Routes

```
discipline://dashboard

discipline://task/{id}

discipline://habit/{id}

discipline://goal/{id}

discipline://focus

discipline://ai

discipline://analytics

discipline://settings
```

---

# 9. Global Navigation Rules

- Preserve navigation state.
- Support back navigation correctly.
- Restore previous tab on app reopen.
- Handle expired sessions gracefully.
- Support offline navigation for cached content.
- Use named routes with GoRouter.
- Protect authenticated routes with route guards.
- Keep transitions under 300 ms.

---

# User Journey Summary

```
Install App
      ↓
Authentication
      ↓
Onboarding
      ↓
Dashboard
      ↓
Create Tasks & Habits
      ↓
AI Guidance
      ↓
Focus Sessions
      ↓
Analytics & Reports
      ↓
Continuous Improvement
```

---

# End of 09_Screens_and_User_Flow.md

Next Document:

**10_Feature_Specification.md**

Includes:
- Detailed specification for every feature
- Business rules
- Edge cases
- Acceptance criteria
- UI behavior
- Database mapping
- AI integration points
- Native Android implementation notes
- Test scenarios