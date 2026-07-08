# Discipline OS

# 11_Native_Android_Implementation.md

Version: 1.0

Status: Approved

Document Type:
Native Android Implementation Specification

---

# Table of Contents

1. Overview

2. Native Module Architecture

3. Flutter ↔ Kotlin Communication

4. UsageStatsManager

5. Accessibility Service

6. Focus App Lock

7. Health Connect

8. Foreground Services

9. WorkManager

10. AlarmManager

11. Boot Receiver

12. Notification Channels

13. Permission Management

14. Battery Optimization

15. Native Testing Strategy

---

# 1. Overview

Flutter is responsible for

- UI
- Business Logic
- State Management
- AI Integration
- Supabase Communication

Native Kotlin is responsible for

- Android-only APIs
- Background Services
- Device Sensors
- Accessibility
- Usage Statistics
- Health Connect
- Alarm Scheduling

---

# 2. Native Module Architecture

```
android/

native/

usage/

health/

focus/

notification/

permission/

battery/

boot/

bridge/

```

Every module must expose a clean API through MethodChannels.

---

# 3. Flutter ↔ Kotlin Communication

## MethodChannel

Channel Name

```
discipline_os/native
```

Supported Methods

```
getUsageStats()

startFocusLock()

stopFocusLock()

requestUsagePermission()

requestAccessibility()

requestBatteryOptimization()

getSteps()

getSleep()

scheduleAlarm()

cancelAlarm()

isHealthConnected()

```

Return Format

```json
{
  "success": true,
  "data": {},
  "message": ""
}
```

---

# 4. UsageStatsManager

## Purpose

Read application usage statistics.

Android API

- UsageStatsManager
- PackageManager
- AppOpsManager

Collected Data

- App Name
- Package Name
- Foreground Time
- Launch Count
- Last Used

Business Rules

- Do not collect unnecessary metadata.
- Aggregate usage by day.
- Respect user permissions.

Fallback

If permission denied:

- Disable Screen Time module.
- Continue running remaining features.

---

# 5. Accessibility Service

Purpose

Block distracting apps during Focus Mode.

Capabilities

- Detect foreground app
- Intercept launch
- Display Focus Lock screen
- Allow emergency exit

Requirements

- Accessibility permission
- Foreground service
- Overlay permission (if required)

Rules

- Never activate without user consent.
- Automatically disable when focus session ends.

---

# 6. Focus App Lock

Workflow

```
User Starts Focus

↓

Blocked Apps Loaded

↓

Accessibility Detects Launch

↓

Intercept

↓

Custom Lock Screen

↓

Return after timer completes
```

Settings

- Allow Whitelist
- Allow Emergency Exit
- Temporary Unlock
- Scheduled Focus Sessions

---

# 7. Health Connect

Purpose

Synchronize health-related information.

Supported Data

- Steps
- Sleep
- Weight
- Exercise
- Calories (future)

Fallback

Manual entry when Health Connect is unavailable.

Sync

- Manual
- Automatic
- Background

---

# 8. Foreground Services

Used For

- Focus Timer
- App Lock
- Background Tracking
- Long-running uploads

Requirements

Persistent notification while active.

Recover gracefully after process restart.

---

# 9. WorkManager

Responsibilities

- Sync pending data
- Generate AI reports
- Upload queued files
- Refresh analytics
- Retry failed requests

Constraints

- Network available
- Battery not critically low (configurable)

---

# 10. AlarmManager

Use Cases

- Habit reminders
- Task reminders
- Goal reminders
- Sleep reminders
- Water reminders

Rules

- Re-register alarms after reboot.
- Support exact alarms where permitted.

---

# 11. Boot Receiver

Triggered On

- Device restart
- App update (where applicable)

Responsibilities

- Restore alarms
- Restart scheduled workers
- Restore focus state if appropriate
- Resume pending synchronization

---

# 12. Notification Channels

Required Channels

- Tasks
- Habits
- Goals
- AI Coach
- Focus
- Health
- System

User Controls

- Enable/Disable
- Sound
- Vibration
- Importance

---

# 13. Permission Management

Runtime Permissions

- Camera
- Notifications
- Microphone
- Activity Recognition
- Photos/Storage

Special Permissions

- Usage Access
- Accessibility
- Ignore Battery Optimization
- Exact Alarm (if required)

Rules

- Request only when needed.
- Explain the purpose before requesting.
- Never block unrelated functionality if denied.

---

# 14. Battery Optimization

Detect

- Battery optimization enabled
- Background restriction
- OEM restrictions

Guide User

- Whitelist app
- Allow background execution
- Disable aggressive battery management (optional guidance)

Fallback

If restricted:

- Continue with reduced functionality.
- Notify user of limitations.

---

# 15. Native Testing Strategy

Unit Tests

- MethodChannel handlers
- Permission helpers
- Usage parsing

Integration Tests

- Flutter ↔ Kotlin bridge
- Health Connect
- UsageStats
- Accessibility lifecycle

Manual QA Checklist

- Focus Lock activates correctly
- Usage data updates
- Notifications fire on schedule
- Boot restore works
- Battery optimization warning displayed
- Background sync resumes after reconnect

---

# Native Coding Standards

- Kotlin latest stable
- MVVM where appropriate
- Small, focused classes
- No business logic duplication
- All native APIs documented
- Error propagation through MethodChannels
- Structured logging
- Defensive permission checks

---

# End of 11_Native_Android_Implementation.md

Next Document:

**12_Google_Cloud_Setup.md**

Contents:
- Google Cloud project setup
- OAuth configuration
- Google Sign-In
- Calendar API
- Health Connect integration
- API key restrictions
- SHA-1/SHA-256 setup
- Android client configuration
- Security best practices
```