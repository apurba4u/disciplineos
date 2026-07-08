# DisciplineOS Foundation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use compose:subagent (recommended) or compose:execute to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create the Flutter project with complete folder structure, core architecture, and working authentication flow as the foundation for all subsequent features.

**Architecture:** Clean Architecture with feature-first structure. Riverpod for state management, GoRouter for navigation, Supabase for backend, Material 3 design system. Each feature follows: data/domain/presentation layers.

**Tech Stack:** Flutter 3.41.9, Dart 3.11.5, Supabase Flutter SDK, Riverpod, GoRouter, Freezed, json_serializable, flutter_secure_storage, dio

## Global Constraints

- Flutter latest stable (3.41.9)
- Android minimum SDK 26+
- Clean Architecture enforced
- Riverpod only for state management
- GoRouter for navigation
- Material 3 design
- All secrets from `.env` via flutter_dotenv
- UUID primary keys everywhere
- No hardcoded secrets
- Offline-first architecture

---

### Task 1: Create Flutter Project and Configure pubspec.yaml

**Covers:** Project setup, folder structure foundation

**Files:**
- Create: `pubspec.yaml` (via flutter create)
- Create: `analysis_options.yaml`
- Create: `.gitignore`

**Steps:**

- [ ] **Step 1: Create Flutter project**

```bash
cd /Users/apurbaovi/Desktop/Project/DisciplineOS
flutter create --org com.discipline --project-name discipline_os --platforms android .
```

- [ ] **Step 2: Update pubspec.yaml with all dependencies**

```yaml
name: discipline_os
description: "Discipline OS - Your AI Powered Life Operating System"
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.11.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1
  
  # Navigation
  go_router: ^14.8.1
  
  # Backend
  supabase_flutter: ^2.8.4
  
  # AI
  # Custom HTTP client for AI providers
  http: ^1.3.0
  
  # Storage
  flutter_secure_storage: ^9.2.4
  shared_preferences: ^2.5.3
  
  # Code Generation
  freezed_annotation: ^2.4.7
  json_annotation: ^4.9.0
  riverpod_generator: ^2.6.3
  
  # Utilities
  intl: ^0.20.2
  uuid: ^4.5.1
  logger: ^2.5.0
  connectivity_plus: ^6.1.3
  path_provider: ^2.1.5
  
  # UI
  flutter_svg: ^2.0.17
  cached_network_image: ^3.4.1
  shimmer: ^3.0.0
  
  # Image handling
  image_picker: ^1.1.2
  image: ^4.5.3
  
  # Environment
  flutter_dotenv: ^5.2.0
  
  # Permissions
  permission_handler: ^11.4.0
  
  # Date/Time
  table_calendar: ^3.2.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  
  # Code Generation
  build_runner: ^2.4.14
  freezed: ^2.5.8
  json_serializable: ^6.9.2
  riverpod_generator: ^2.6.3
  riverpod_lint: ^2.6.3
  
  # Testing
  mocktail: ^1.0.4
  
  # Analysis
  dart_code_metrics: ^5.7.6

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
    - assets/fonts/
    - .env
  
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
        - asset: assets/fonts/Inter-Medium.ttf
          weight: 500
        - asset: assets/fonts/Inter-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
```

- [ ] **Step 3: Update analysis_options.yaml**

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  errors:
    invalid_annotation_target: ignore

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_declarations
    - prefer_final_locals
    - avoid_print
    - require_trailing_commas
    - prefer_single_quotes
    - sort_child_properties_last
    - use_key_in_widget_constructors
    - prefer_relative_imports
    - public_member_api_docs: false
```

- [ ] **Step 4: Install dependencies**

```bash
cd /Users/apurbaovi/Desktop/Project/DisciplineOS
flutter pub get
```

- [ ] **Step 5: Commit**

```bash
git add pubspec.yaml analysis_options.yaml pubspec.lock
git commit -m "feat(project): initialize Flutter project with core dependencies"
```

---

### Task 2: Create Complete Folder Structure

**Covers:** Folder structure per doc 16

**Files:**
- Create: All directories under `lib/`
- Create: All directories under `assets/`
- Create: `.env.dev`, `.env.staging`, `.env.production`

**Steps:**

- [ ] **Step 1: Create lib directory structure**

```bash
cd /Users/apurbaovi/Desktop/Project/DisciplineOS

# Core module
mkdir -p lib/core/config
mkdir -p lib/core/constants
mkdir -p lib/core/errors
mkdir -p lib/core/exceptions
mkdir -p lib/core/extensions
mkdir -p lib/core/helpers
mkdir -p lib/core/logger
mkdir -p lib/core/network
mkdir -p lib/core/permissions
mkdir -p lib/core/router
mkdir -p lib/core/security
mkdir -p lib/core/services
mkdir -p lib/core/storage
mkdir -p lib/core/theme
mkdir -p lib/core/utils
mkdir -p lib/core/widgets

# Shared module
mkdir -p lib/shared/components
mkdir -p lib/shared/dialogs
mkdir -p lib/shared/models
mkdir -p lib/shared/widgets
mkdir -p lib/shared/mixins
mkdir -p lib/shared/enums
mkdir -p lib/shared/validators

# Feature modules
mkdir -p lib/features/auth/data/datasources
mkdir -p lib/features/auth/data/models
mkdir -p lib/features/auth/data/repositories
mkdir -p lib/features/auth/domain/entities
mkdir -p lib/features/auth/domain/repositories
mkdir -p lib/features/auth/domain/usecases
mkdir -p lib/features/auth/presentation/pages
mkdir -p lib/features/auth/presentation/widgets
mkdir -p lib/features/auth/presentation/controllers
mkdir -p lib/features/auth/presentation/providers

mkdir -p lib/features/dashboard/data/datasources
mkdir -p lib/features/dashboard/data/models
mkdir -p lib/features/dashboard/data/repositories
mkdir -p lib/features/dashboard/domain/entities
mkdir -p lib/features/dashboard/domain/repositories
mkdir -p lib/features/dashboard/domain/usecases
mkdir -p lib/features/dashboard/presentation/pages
mkdir -p lib/features/dashboard/presentation/widgets
mkdir -p lib/features/dashboard/presentation/controllers
mkdir -p lib/features/dashboard/presentation/providers

mkdir -p lib/features/tasks/data/datasources
mkdir -p lib/features/tasks/data/models
mkdir -p lib/features/tasks/data/repositories
mkdir -p lib/features/tasks/domain/entities
mkdir -p lib/features/tasks/domain/repositories
mkdir -p lib/features/tasks/domain/usecases
mkdir -p lib/features/tasks/presentation/pages
mkdir -p lib/features/tasks/presentation/widgets
mkdir -p lib/features/tasks/presentation/controllers
mkdir -p lib/features/tasks/presentation/providers

mkdir -p lib/features/habits/data/datasources
mkdir -p lib/features/habits/data/models
mkdir -p lib/features/habits/data/repositories
mkdir -p lib/features/habits/domain/entities
mkdir -p lib/features/habits/domain/repositories
mkdir -p lib/features/habits/domain/usecases
mkdir -p lib/features/habits/presentation/pages
mkdir -p lib/features/habits/presentation/widgets
mkdir -p lib/features/habits/presentation/controllers
mkdir -p lib/features/habits/presentation/providers

mkdir -p lib/features/goals/data/datasources
mkdir -p lib/features/goals/data/models
mkdir -p lib/features/goals/data/repositories
mkdir -p lib/features/goals/domain/entities
mkdir -p lib/features/goals/domain/repositories
mkdir -p lib/features/goals/domain/usecases
mkdir -p lib/features/goals/presentation/pages
mkdir -p lib/features/goals/presentation/widgets
mkdir -p lib/features/goals/presentation/controllers
mkdir -p lib/features/goals/presentation/providers

mkdir -p lib/features/calendar/data/datasources
mkdir -p lib/features/calendar/data/models
mkdir -p lib/features/calendar/data/repositories
mkdir -p lib/features/calendar/domain/entities
mkdir -p lib/features/calendar/domain/repositories
mkdir -p lib/features/calendar/domain/usecases
mkdir -p lib/features/calendar/presentation/pages
mkdir -p lib/features/calendar/presentation/widgets
mkdir -p lib/features/calendar/presentation/controllers
mkdir -p lib/features/calendar/presentation/providers

mkdir -p lib/features/focus/data/datasources
mkdir -p lib/features/focus/data/models
mkdir -p lib/features/focus/data/repositories
mkdir -p lib/features/focus/domain/entities
mkdir -p lib/features/focus/domain/repositories
mkdir -p lib/features/focus/domain/usecases
mkdir -p lib/features/focus/presentation/pages
mkdir -p lib/features/focus/presentation/widgets
mkdir -p lib/features/focus/presentation/controllers
mkdir -p lib/features/focus/presentation/providers

mkdir -p lib/features/analytics/data/datasources
mkdir -p lib/features/analytics/data/models
mkdir -p lib/features/analytics/data/repositories
mkdir -p lib/features/analytics/domain/entities
mkdir -p lib/features/analytics/domain/repositories
mkdir -p lib/features/analytics/domain/usecases
mkdir -p lib/features/analytics/presentation/pages
mkdir -p lib/features/analytics/presentation/widgets
mkdir -p lib/features/analytics/presentation/controllers
mkdir -p lib/features/analytics/presentation/providers

mkdir -p lib/features/health/data/datasources
mkdir -p lib/features/health/data/models
mkdir -p lib/features/health/data/repositories
mkdir -p lib/features/health/domain/entities
mkdir -p lib/features/health/domain/repositories
mkdir -p lib/features/health/domain/usecases
mkdir -p lib/features/health/presentation/pages
mkdir -p lib/features/health/presentation/widgets
mkdir -p lib/features/health/presentation/controllers
mkdir -p lib/features/health/presentation/providers

mkdir -p lib/features/notifications/data/datasources
mkdir -p lib/features/notifications/data/models
mkdir -p lib/features/notifications/data/repositories
mkdir -p lib/features/notifications/domain/entities
mkdir -p lib/features/notifications/domain/repositories
mkdir -p lib/features/notifications/domain/usecases
mkdir -p lib/features/notifications/presentation/pages
mkdir -p lib/features/notifications/presentation/widgets
mkdir -p lib/features/notifications/presentation/controllers
mkdir -p lib/features/notifications/presentation/providers

mkdir -p lib/features/settings/data/datasources
mkdir -p lib/features/settings/data/models
mkdir -p lib/features/settings/data/repositories
mkdir -p lib/features/settings/domain/entities
mkdir -p lib/features/settings/domain/repositories
mkdir -p lib/features/settings/domain/usecases
mkdir -p lib/features/settings/presentation/pages
mkdir -p lib/features/settings/presentation/widgets
mkdir -p lib/features/settings/presentation/controllers
mkdir -p lib/features/settings/presentation/providers

mkdir -p lib/features/ai/data/datasources
mkdir -p lib/features/ai/data/models
mkdir -p lib/features/ai/data/repositories
mkdir -p lib/features/ai/domain/entities
mkdir -p lib/features/ai/domain/repositories
mkdir -p lib/features/ai/domain/usecases
mkdir -p lib/features/ai/presentation/pages
mkdir -p lib/features/ai/presentation/widgets
mkdir -p lib/features/ai/presentation/controllers
mkdir -p lib/features/ai/presentation/providers

mkdir -p lib/features/profile/data/datasources
mkdir -p lib/features/profile/data/models
mkdir -p lib/features/profile/data/repositories
mkdir -p lib/features/profile/domain/entities
mkdir -p lib/features/profile/domain/repositories
mkdir -p lib/features/profile/domain/usecases
mkdir -p lib/features/profile/presentation/pages
mkdir -p lib/features/profile/presentation/widgets
mkdir -p lib/features/profile/presentation/controllers
mkdir -p lib/features/profile/presentation/providers

mkdir -p lib/features/social/data/datasources
mkdir -p lib/features/social/data/models
mkdir -p lib/features/social/data/repositories
mkdir -p lib/features/social/domain/entities
mkdir -p lib/features/social/domain/repositories
mkdir -p lib/features/social/domain/usecases
mkdir -p lib/features/social/presentation/pages
mkdir -p lib/features/social/presentation/widgets
mkdir -p lib/features/social/presentation/controllers
mkdir -p lib/features/social/presentation/providers

mkdir -p lib/features/gamification/data/datasources
mkdir -p lib/features/gamification/data/models
mkdir -p lib/features/gamification/data/repositories
mkdir -p lib/features/gamification/domain/entities
mkdir -p lib/features/gamification/domain/repositories
mkdir -p lib/features/gamification/domain/usecases
mkdir -p lib/features/gamification/presentation/pages
mkdir -p lib/features/gamification/presentation/widgets
mkdir -p lib/features/gamification/presentation/controllers
mkdir -p lib/features/gamification/presentation/providers

mkdir -p lib/features/screen_time/data/datasources
mkdir -p lib/features/screen_time/data/models
mkdir -p lib/features/screen_time/data/repositories
mkdir -p lib/features/screen_time/domain/entities
mkdir -p lib/features/screen_time/domain/repositories
mkdir -p lib/features/screen_time/domain/usecases
mkdir -p lib/features/screen_time/presentation/pages
mkdir -p lib/features/screen_time/presentation/widgets
mkdir -p lib/features/screen_time/presentation/controllers
mkdir -p lib/features/screen_time/presentation/providers

mkdir -p lib/features/proof/data/datasources
mkdir -p lib/features/proof/data/models
mkdir -p lib/features/proof/data/repositories
mkdir -p lib/features/proof/domain/entities
mkdir -p lib/features/proof/domain/repositories
mkdir -p lib/features/proof/domain/usecases
mkdir -p lib/features/proof/presentation/pages
mkdir -p lib/features/proof/presentation/widgets
mkdir -p lib/features/proof/presentation/controllers
mkdir -p lib/features/proof/presentation/providers

# Test directories
mkdir -p test/unit
mkdir -p test/widget
mkdir -p test/integration
mkdir -p integration_test

# Asset directories
mkdir -p assets/images
mkdir -p assets/icons
mkdir -p assets/fonts
mkdir -p assets/animations
mkdir -p assets/lottie
```

- [ ] **Step 2: Create environment files**

Create `.env.dev`:
```
SUPABASE_URL=your_dev_supabase_url
SUPABASE_ANON_KEY=your_dev_supabase_anon_key
GEMINI_API_KEY=your_dev_gemini_key
DEEPSEEK_API_KEY=your_dev_deepseek_key
GOOGLE_API_KEY=your_dev_google_key
GOOGLE_CLIENT_ID=your_dev_google_client_id
```

Create `.env.staging` and `.env.production` with same structure.

- [ ] **Step 3: Update .gitignore**

Add to `.gitignore`:
```
# Environment files
.env
.env.*
.env.dev
.env.staging
.env.production

# Generated files
*.g.dart
*.freezed.dart

# Build
build/
.dart_tool/
.packages
pubspec.lock

# IDE
.vscode/
.idea/
*.iml

# OS
.DS_Store
Thumbs.db

# Android
android/local.properties
android/key.properties
*.jks
*.keystore

# iOS
ios/Pods/
ios/.symlinks/
ios/Flutter/Flutter.framework
ios/Flutter/Flutter.podspec

# Coverage
coverage/

# Logs
*.log
```

- [ ] **Step 4: Commit**

```bash
git add -A
git commit -m "feat(project): create complete folder structure and environment config"
```

---

### Task 3: Implement Core Theme System

**Covers:** Theme system per doc 08 (color system, typography, spacing)

**Files:**
- Create: `lib/core/theme/app_theme.dart`
- Create: `lib/core/theme/app_colors.dart`
- Create: `lib/core/theme/app_text_styles.dart`
- Create: `lib/core/theme/app_spacing.dart`
- Create: `lib/core/theme/app_dimensions.dart`

**Steps:**

- [ ] **Step 1: Create app_colors.dart**

```dart
import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary
  static const Color primary = Color(0xFF4F46E5);
  static const Color secondary = Color(0xFF7C3AED);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Light theme
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFE2E8F0);
  static const Color lightOutline = Color(0xFFCBD5E1);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);

  // Dark theme
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkDivider = Color(0xFF334155);
  static const Color darkOutline = Color(0xFF475569);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  // AMOLED theme
  static const Color amoledBackground = Color(0xFF000000);
  static const Color amoledSurface = Color(0xFF0A0A0A);
  static const Color amoledCard = Color(0xFF111111);

  // Accent colors
  static const Color blue = Color(0xFF3B82F6);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color green = Color(0xFF10B981);
  static const Color orange = Color(0xFFF97316);
  static const Color red = Color(0xFFEF4444);
  static const Color pink = Color(0xFFEC4899);
  static const Color teal = Color(0xFF14B8A6);
  static const Color indigo = Color(0xFF6366F1);
}
```

- [ ] **Step 2: Create app_text_styles.dart**

```dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTextStyles {
  static const String _fontFamily = 'Inter';

  // Display
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 45,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w400,
  );

  // Headline
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // Title
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  // Label
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
}
```

- [ ] **Step 3: Create app_spacing.dart**

```dart
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double xxxxl = 40;
  static const double xxxxxl = 48;
  static const double huge = 64;
}
```

- [ ] **Step 4: Create app_dimensions.dart**

```dart
abstract final class AppDimensions {
  // Border Radius
  static const double buttonRadius = 12;
  static const double cardRadius = 16;
  static const double dialogRadius = 20;
  static const double bottomSheetRadius = 24;
  static const double chipRadius = 999;
  static const double inputRadius = 12;

  // Elevation
  static const double elevation0 = 0;
  static const double elevation1 = 1;
  static const double elevation2 = 2;
  static const double elevation4 = 4;
  static const double elevation8 = 8;
  static const double elevation12 = 12;
  static const double elevation16 = 16;

  // Touch target
  static const double minTouchTarget = 48;

  // Icon sizes
  static const double iconSm = 16;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 48;
}
```

- [ ] **Step 5: Create app_theme.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_dimensions.dart';

abstract final class AppTheme {
  static ThemeData lightTheme({Color? accentColor}) {
    final primary = accentColor ?? AppColors.primary;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: AppColors.secondary,
        surface: AppColors.lightSurface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightTextPrimary,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      cardColor: AppColors.lightCard,
      dividerColor: AppColors.lightDivider,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: primary,
        unselectedItemColor: AppColors.lightTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: AppDimensions.elevation8,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: AppDimensions.elevation4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: AppDimensions.elevation1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(color: AppColors.lightOutline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(color: AppColors.lightOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: AppDimensions.elevation2,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
          textStyle: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: BorderSide(color: primary),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
          textStyle: AppTextStyles.labelLarge.copyWith(color: primary),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          textStyle: AppTextStyles.labelLarge.copyWith(color: primary),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedColor: primary.withAlpha(30),
        side: BorderSide(color: AppColors.lightOutline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.chipRadius),
        ),
        labelStyle: AppTextStyles.labelMedium,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.lightSurface,
        elevation: AppDimensions.elevation16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.dialogRadius),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.lightSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.bottomSheetRadius),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkSurface,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
      ),
    );
  }

  static ThemeData darkTheme({Color? accentColor}) {
    final primary = accentColor ?? AppColors.primary;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: AppColors.secondary,
        surface: AppColors.darkSurface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkTextPrimary,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      cardColor: AppColors.darkCard,
      dividerColor: AppColors.darkDivider,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: primary,
        unselectedItemColor: AppColors.darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: AppDimensions.elevation8,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: AppDimensions.elevation4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: AppDimensions.elevation1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(color: AppColors.darkOutline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(color: AppColors.darkOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: AppDimensions.elevation2,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
          textStyle: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: BorderSide(color: primary),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
          textStyle: AppTextStyles.labelLarge.copyWith(color: primary),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          textStyle: AppTextStyles.labelLarge.copyWith(color: primary),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedColor: primary.withAlpha(30),
        side: BorderSide(color: AppColors.darkOutline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.chipRadius),
        ),
        labelStyle: AppTextStyles.labelMedium,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkSurface,
        elevation: AppDimensions.elevation16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.dialogRadius),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.darkSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.bottomSheetRadius),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.lightSurface,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
      ),
    );
  }

  static ThemeData amoledTheme({Color? accentColor}) {
    final primary = accentColor ?? AppColors.primary;
    return darkTheme(accentColor: accentColor).copyWith(
      scaffoldBackgroundColor: AppColors.amoledBackground,
      cardColor: AppColors.amoledCard,
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: AppColors.secondary,
        surface: AppColors.amoledSurface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkTextPrimary,
        onError: Colors.white,
      ),
    );
  }
}
```

- [ ] **Step 6: Commit**

```bash
git add lib/core/theme/
git commit -m "feat(theme): implement Material 3 theme system with light/dark/AMOLED"
```

---

### Task 4: Implement Core Configuration and Services

**Covers:** App configuration, environment setup, Supabase initialization

**Files:**
- Create: `lib/core/config/env_config.dart`
- Create: `lib/core/config/supabase_config.dart`
- Create: `lib/core/services/app_service.dart`
- Create: `lib/core/network/network_info.dart`

**Steps:**

- [ ] **Step 1: Create env_config.dart**

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class EnvConfig {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  static String get geminiApiKey => dotenv.env['GEMINI_API_KEY'] ?? '';
  static String get deepseekApiKey => dotenv.env['DEEPSEEK_API_KEY'] ?? '';
  static String get googleApiKey => dotenv.env['GOOGLE_API_KEY'] ?? '';
  static String get googleClientId => dotenv.env['GOOGLE_CLIENT_ID'] ?? '';

  static bool get isConfigured =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
```

- [ ] **Step 2: Create network_info.dart**

```dart
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfo(this._connectivity);

  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Stream<ConnectivityResult> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
```

- [ ] **Step 3: Create app_service.dart**

```dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env_config.dart';

class AppService {
  static final AppService _instance = AppService._internal();
  factory AppService() => _instance;
  AppService._internal();

  SupabaseClient? _supabaseClient;

  SupabaseClient get supabase {
    if (_supabaseClient == null) {
      throw Exception('Supabase not initialized. Call AppService.initialize() first.');
    }
    return _supabaseClient!;
  }

  bool _initialized = false;
  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (_initialized) return;

    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );

    _supabaseClient = Supabase.instance.client;
    _initialized = true;
  }

  void dispose() {
    _supabaseClient?.dispose();
    _supabaseClient = null;
    _initialized = false;
  }
}
```

- [ ] **Step 4: Commit**

```bash
git add lib/core/config/ lib/core/services/ lib/core/network/
git commit -m "feat(core): implement configuration, services, and network layer"
```

---

### Task 5: Implement Core Router

**Covers:** Navigation structure per doc 09

**Files:**
- Create: `lib/core/router/app_router.dart`
- Create: `lib/core/router/route_names.dart`

**Steps:**

- [ ] **Step 1: Create route_names.dart**

```dart
abstract final class RouteNames {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const onboarding = '/onboarding';
  static const dashboard = '/dashboard';
  static const tasks = '/tasks';
  static const taskDetails = '/tasks/:id';
  static const createTask = '/tasks/create';
  static const habits = '/habits';
  static const habitDetails = '/habits/:id';
  static const createHabit = '/habits/create';
  static const goals = '/goals';
  static const goalDetails = '/goals/:id';
  static const createGoal = '/goals/create';
  static const ai = '/ai';
  static const aiChat = '/ai/chat';
  static const analytics = '/analytics';
  static const health = '/health';
  static const focus = '/focus';
  static const calendar = '/calendar';
  static const settings = '/settings';
  static const profile = '/profile';
  static const notifications = '/notifications';
}
```

- [ ] **Step 2: Create app_router.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splash,
    routes: [
      // Auth routes
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Login')),
        ),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Register')),
        ),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Forgot Password')),
        ),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Onboarding')),
        ),
      ),

      // Main shell with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Scaffold(body: Center(child: Text('Dashboard'))),
            ),
          ),
          GoRoute(
            path: RouteNames.tasks,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Scaffold(body: Center(child: Text('Tasks'))),
            ),
          ),
          GoRoute(
            path: RouteNames.ai,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Scaffold(body: Center(child: Text('AI Coach'))),
            ),
          ),
          GoRoute(
            path: RouteNames.analytics,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Scaffold(body: Center(child: Text('Analytics'))),
            ),
          ),
          GoRoute(
            path: RouteNames.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Scaffold(body: Center(child: Text('Profile'))),
            ),
          ),
        ],
      ),

      // Detail routes
      GoRoute(
        path: RouteNames.taskDetails,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Task Details')),
        ),
      ),
      GoRoute(
        path: RouteNames.createTask,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Create Task')),
        ),
      ),
      GoRoute(
        path: RouteNames.habitDetails,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Habit Details')),
        ),
      ),
      GoRoute(
        path: RouteNames.createHabit,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Create Habit')),
        ),
      ),
      GoRoute(
        path: RouteNames.goalDetails,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Goal Details')),
        ),
      ),
      GoRoute(
        path: RouteNames.createGoal,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Create Goal')),
        ),
      ),
      GoRoute(
        path: RouteNames.focus,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Focus Mode')),
        ),
      ),
      GoRoute(
        path: RouteNames.calendar,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Calendar')),
        ),
      ),
      GoRoute(
        path: RouteNames.settings,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Settings')),
        ),
      ),
      GoRoute(
        path: RouteNames.notifications,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Notifications')),
        ),
      ),
    ],
  );
});

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            activeIcon: Icon(Icons.task),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology_outlined),
            activeIcon: Icon(Icons.psychology),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/tasks')) return 1;
    if (location.startsWith('/ai')) return 2;
    if (location.startsWith('/analytics')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(RouteNames.dashboard);
      case 1:
        context.go(RouteNames.tasks);
      case 2:
        context.go(RouteNames.ai);
      case 3:
        context.go(RouteNames.analytics);
      case 4:
        context.go(RouteNames.profile);
    }
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add lib/core/router/
git commit -m "feat(router): implement GoRouter navigation with bottom nav shell"
```

---

### Task 6: Implement Shared Enums and Validators

**Covers:** Shared models, enums, validators

**Files:**
- Create: `lib/shared/enums/task_priority.dart`
- Create: `lib/shared/enums/task_status.dart`
- Create: `lib/shared/enums/habit_frequency.dart`
- Create: `lib/shared/enums/goal_status.dart`
- Create: `lib/shared/enums/goal_category.dart`
- Create: `lib/shared/enums/ai_provider.dart`
- Create: `lib/shared/enums/theme_mode.dart`
- Create: `lib/shared/validators/auth_validator.dart`
- Create: `lib/shared/validators/task_validator.dart`

**Steps:**

- [ ] **Step 1: Create shared enums**

```dart
// lib/shared/enums/task_priority.dart
enum TaskPriority {
  low,
  medium,
  high,
  urgent;

  String get label {
    switch (this) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
      case TaskPriority.urgent:
        return 'Urgent';
    }
  }

  int get order {
    switch (this) {
      case TaskPriority.urgent:
        return 0;
      case TaskPriority.high:
        return 1;
      case TaskPriority.medium:
        return 2;
      case TaskPriority.low:
        return 3;
    }
  }
}
```

```dart
// lib/shared/enums/task_status.dart
enum TaskStatus {
  pending,
  inProgress,
  completed,
  cancelled,
  overdue;

  String get label {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.cancelled:
        return 'Cancelled';
      case TaskStatus.overdue:
        return 'Overdue';
    }
  }
}
```

```dart
// lib/shared/enums/habit_frequency.dart
enum HabitFrequency {
  daily,
  weekly,
  monthly;

  String get label {
    switch (this) {
      case HabitFrequency.daily:
        return 'Daily';
      case HabitFrequency.weekly:
        return 'Weekly';
      case HabitFrequency.monthly:
        return 'Monthly';
    }
  }
}
```

```dart
// lib/shared/enums/goal_status.dart
enum GoalStatus {
  notStarted,
  active,
  paused,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case GoalStatus.notStarted:
        return 'Not Started';
      case GoalStatus.active:
        return 'Active';
      case GoalStatus.paused:
        return 'Paused';
      case GoalStatus.completed:
        return 'Completed';
      case GoalStatus.cancelled:
        return 'Cancelled';
    }
  }
}
```

```dart
// lib/shared/enums/goal_category.dart
enum GoalCategory {
  academic,
  career,
  health,
  fitness,
  finance,
  business,
  personal,
  research;

  String get label {
    switch (this) {
      case GoalCategory.academic:
        return 'Academic';
      case GoalCategory.career:
        return 'Career';
      case GoalCategory.health:
        return 'Health';
      case GoalCategory.fitness:
        return 'Fitness';
      case GoalCategory.finance:
        return 'Finance';
      case GoalCategory.business:
        return 'Business';
      case GoalCategory.personal:
        return 'Personal';
      case GoalCategory.research:
        return 'Research';
    }
  }
}
```

```dart
// lib/shared/enums/ai_provider.dart
enum AIProviderType {
  gemini,
  deepSeek;

  String get label {
    switch (this) {
      case AIProviderType.gemini:
        return 'Gemini';
      case AIProviderType.deepSeek:
        return 'DeepSeek';
    }
  }
}
```

```dart
// lib/shared/enums/theme_mode.dart
enum AppThemeMode {
  system,
  light,
  dark,
  amoled;

  String get label {
    switch (this) {
      case AppThemeMode.system:
        return 'System Default';
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.amoled:
        return 'AMOLED';
    }
  }
}
```

- [ ] **Step 2: Create validators**

```dart
// lib/shared/validators/auth_validator.dart
class AuthValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }
}
```

```dart
// lib/shared/validators/task_validator.dart
class TaskValidator {
  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  static String? validateDeadline(DateTime? value) {
    if (value == null) {
      return 'Deadline is required';
    }
    if (value.isBefore(DateTime.now())) {
      return 'Deadline cannot be in the past';
    }
    return null;
  }

  static String? validateEstimatedDuration(int? minutes) {
    if (minutes == null || minutes <= 0) {
      return 'Estimated duration must be greater than 0';
    }
    return null;
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add lib/shared/
git commit -m "feat(shared): implement enums and validators for core entities"
```

---

### Task 7: Implement Core Error Handling

**Covers:** Error handling patterns per doc 17

**Files:**
- Create: `lib/core/errors/failures.dart`
- Create: `lib/core/exceptions/app_exceptions.dart`

**Steps:**

- [ ] **Step 1: Create failures.dart**

```dart
abstract class Failure {
  final String message;
  const Failure({required this.message});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error occurred'});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'});
}

class AuthFailure extends Failure {
  const AuthFailure({super.message = 'Authentication failed'});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error occurred'});
}

class ValidationFailure extends Failure {
  const ValidationFailure({super.message = 'Validation failed'});
}

class AIProviderFailure extends Failure {
  const AIProviderFailure({super.message = 'AI provider error'});
}

class StorageFailure extends Failure {
  const StorageFailure({super.message = 'Storage error occurred'});
}
```

- [ ] **Step 2: Create app_exceptions.dart**

```dart
class AppException implements Exception {
  final String message;
  final String? code;
  const AppException({required this.message, this.code});

  @override
  String toString() => 'AppException: $message (code: $code)';
}

class NetworkException extends AppException {
  const NetworkException({super.message = 'No internet connection', super.code = 'NETWORK_ERROR'});
}

class AuthException extends AppException {
  const AuthException({super.message = 'Authentication failed', super.code = 'AUTH_ERROR'});
}

class ValidationException extends AppException {
  const ValidationException({super.message = 'Validation failed', super.code = 'VALIDATION_ERROR'});
}

class AIException extends AppException {
  const AIException({super.message = 'AI provider error', super.code = 'AI_ERROR'});
}

class StorageException extends AppException {
  const StorageException({super.message = 'Storage error', super.code = 'STORAGE_ERROR'});
}

class ServerException extends AppException {
  const ServerException({super.message = 'Server error', super.code = 'SERVER_ERROR'});
}
```

- [ ] **Step 3: Commit**

```bash
git add lib/core/errors/ lib/core/exceptions/
git commit -m "feat(core): implement error handling with failures and exceptions"
```

---

### Task 8: Implement Auth Domain Layer

**Covers:** Auth module per doc 03 SRS Part 1 (AUTH-001 to AUTH-008)

**Files:**
- Create: `lib/features/auth/domain/entities/user.dart`
- Create: `lib/features/auth/domain/repositories/auth_repository.dart`
- Create: `lib/features/auth/domain/usecases/sign_in_usecase.dart`
- Create: `lib/features/auth/domain/usecases/sign_up_usecase.dart`
- Create: `lib/features/auth/domain/usecases/sign_out_usecase.dart`

**Steps:**

- [ ] **Step 1: Create user entity**

```dart
class User {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final String? occupation;
  final String? timezone;
  final String? language;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.occupation,
    this.timezone,
    this.language,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
    String? occupation,
    String? timezone,
    String? language,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      occupation: occupation ?? this.occupation,
      timezone: timezone ?? this.timezone,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
```

- [ ] **Step 2: Create auth repository interface**

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, void>> resetPassword({required String email});

  Stream<User?> get authStateChanges;
}
```

- [ ] **Step 3: Create use cases**

```dart
// lib/features/auth/domain/usecases/sign_in_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) {
    return _repository.signIn(email: email, password: password);
  }
}
```

```dart
// lib/features/auth/domain/usecases/sign_up_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<Failure, User>> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repository.signUp(name: name, email: email, password: password);
  }
}
```

```dart
// lib/features/auth/domain/usecases/sign_out_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<Either<Failure, void>> call() {
    return _repository.signOut();
  }
}
```

- [ ] **Step 4: Add dartz dependency**

Update `pubspec.yaml` to add:
```yaml
dependencies:
  dartz: ^0.10.1
```

Run `flutter pub get`

- [ ] **Step 5: Commit**

```bash
git add lib/features/auth/domain/
git commit -m "feat(auth): implement domain layer with entities, repository interface, use cases"
```

---

### Task 9: Implement Auth Data Layer

**Covers:** Auth data source, repository implementation

**Files:**
- Create: `lib/features/auth/data/models/user_model.dart`
- Create: `lib/features/auth/data/datasources/auth_remote_datasource.dart`
- Create: `lib/features/auth/data/repositories/auth_repository_impl.dart`

**Steps:**

- [ ] **Step 1: Create user model**

```dart
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.photoUrl,
    super.occupation,
    super.timezone,
    super.language,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String? ?? '',
      photoUrl: json['photo_url'] as String?,
      occupation: json['occupation'] as String?,
      timezone: json['timezone'] as String?,
      language: json['language'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  factory UserModel.fromSupabaseUser(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String? ?? '',
      name: json['user_metadata']?['name'] as String? ?? '',
      photoUrl: json['user_metadata']?['photo_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photo_url': photoUrl,
      'occupation': occupation,
      'timezone': timezone,
      'language': language,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserModel copyWithModel({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
    String? occupation,
    String? timezone,
    String? language,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      occupation: occupation ?? this.occupation,
      timezone: timezone ?? this.timezone,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
```

- [ ] **Step 2: Create auth remote datasource**

```dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/exceptions/app_exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<User> signIn({required String email, required String password});
  Future<User> signUp({required String name, required String email, required String password});
  Future<void> signOut();
  Future<User> getCurrentUser();
  Future<void> resetPassword({required String email});
  Stream<User?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<User> signIn({required String email, required String password}) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const AuthException(message: 'Sign in failed');
      }

      return _mapUser(response.user!);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) {
        throw const AuthException(message: 'Sign up failed');
      }

      return _mapUser(response.user!);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        throw const AuthException(message: 'No user logged in');
      }
      return _mapUser(user);
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  @override
  Stream<User?> get authStateChanges {
    return _client.auth.onAuthStateChange.map((event) {
      if (event.session?.user != null) {
        return _mapUser(event.session!.user);
      }
      return null;
    });
  }

  User _mapUser(UserMetadata user) {
    return User(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] as String? ?? '',
      photoUrl: user.userMetadata?['photo_url'] as String?,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}
```

- [ ] **Step 3: Create auth repository implementation**

```dart
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(user);
    } on supabase.AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );
      return Right(user);
    } on supabase.AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await _remoteDataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await _remoteDataSource.resetPassword(email: email);
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Stream<User?> get authStateChanges => _remoteDataSource.authStateChanges;
}
```

- [ ] **Step 4: Commit**

```bash
git add lib/features/auth/data/
git commit -m "feat(auth): implement data layer with Supabase integration"
```

---

### Task 10: Implement Auth Presentation Layer

**Covers:** Auth UI (login, register), state management

**Files:**
- Create: `lib/features/auth/presentation/controllers/auth_controller.dart`
- Create: `lib/features/auth/presentation/pages/login_page.dart`
- Create: `lib/features/auth/presentation/pages/register_page.dart`
- Create: `lib/features/auth/presentation/widgets/auth_form.dart`

**Steps:**

- [ ] **Step 1: Create auth controller**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;

  AuthController({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _signOutUseCase = signOutUseCase,
        super(const AuthState());

  Future<void> signIn({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    final result = await _signInUseCase(email: email, password: password);
    result.fold(
      (failure) => state = state.copyWith(
        status: AuthStatus.error,
        error: failure.message,
      ),
      (user) => state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ),
    );
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    final result = await _signUpUseCase(
      name: name,
      email: email,
      password: password,
    );
    result.fold(
      (failure) => state = state.copyWith(
        status: AuthStatus.error,
        error: failure.message,
      ),
      (user) => state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ),
    );
  }

  Future<void> signOut() async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    final result = await _signOutUseCase();
    result.fold(
      (failure) => state = state.copyWith(
        status: AuthStatus.error,
        error: failure.message,
      ),
      (_) => state = const AuthState(
        status: AuthStatus.unauthenticated,
      ),
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
```

- [ ] **Step 2: Create login page**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../shared/validators/auth_validator.dart';
import '../widgets/auth_form.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: AuthValidator.validateEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: AuthValidator.validatePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(RouteNames.forgotPassword),
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _handleSignIn,
                  child: const Text('Sign In'),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _handleGoogleSignIn,
                  icon: const Icon(Icons.g_mobiledata, size: 24),
                  label: const Text('Continue with Google'),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () => context.push(RouteNames.register),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement sign in via auth controller
    }
  }

  void _handleGoogleSignIn() {
    // TODO: Implement Google sign in
  }
}
```

- [ ] **Step 3: Create register page**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../shared/validators/auth_validator.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Start your discipline journey',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: _nameController,
                  validator: AuthValidator.validateName,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: AuthValidator.validateEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: AuthValidator.validatePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (value) => AuthValidator.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock_outlined),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _handleSignUp,
                  child: const Text('Create Account'),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement sign up via auth controller
    }
  }
}
```

- [ ] **Step 4: Commit**

```bash
git add lib/features/auth/presentation/
git commit -m "feat(auth): implement presentation layer with login and register pages"
```

---

### Task 11: Implement App Entry Point

**Covers:** Main app initialization, provider setup

**Files:**
- Modify: `lib/main.dart`
- Create: `lib/bootstrap.dart`

**Steps:**

- [ ] **Step 1: Create bootstrap.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/supabase_config.dart';

Future<ProviderContainer> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await AppService().initialize();
  
  return ProviderContainer();
}
```

- [ ] **Step 2: Update main.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/supabase_config.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load();
  
  // Initialize services
  await AppService().initialize();
  
  runApp(const ProviderScope(child: DisciplineOSApp()));
}

class DisciplineOSApp extends ConsumerWidget {
  const DisciplineOSApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Discipline OS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
```

- [ ] **Step 3: Verify project compiles**

```bash
cd /Users/apurbaovi/Desktop/Project/DisciplineOS
flutter analyze
```

- [ ] **Step 4: Commit**

```bash
git add lib/main.dart lib/bootstrap.dart
git commit -m "feat(app): implement main entry point with theme and router setup"
```

---

### Task 12: Add Google Fonts to Assets

**Covers:** Font system per doc 08

**Files:**
- Create: Download Inter font files to `assets/fonts/`

**Steps:**

- [ ] **Step 1: Download Inter font**

```bash
cd /Users/apurbaovi/Desktop/Project/DisciplineOS
# Download Inter font from Google Fonts
curl -L -o assets/fonts/Inter-Regular.ttf "https://github.com/rsms/inter/raw/master/docs/font-files/Inter-Regular.otf"
curl -L -o assets/fonts/Inter-Medium.ttf "https://github.com/rsms/inter/raw/master/docs/font-files/Inter-Medium.otf"
curl -L -o assets/fonts/Inter-SemiBold.ttf "https://github.com/rsms/inter/raw/master/docs/font-files/Inter-SemiBold.otf"
curl -L -o assets/fonts/Inter-Bold.ttf "https://github.com/rsms/inter/raw/master/docs/font-files/Inter-Bold.otf"
```

- [ ] **Step 2: Commit**

```bash
git add assets/fonts/
git commit -m "feat(assets): add Inter font family"
```

---

## Summary

This plan covers:
1. ✅ Flutter project creation with dependencies
2. ✅ Complete folder structure per doc 16
3. ✅ Theme system (light/dark/AMOLED) per doc 08
4. ✅ Core configuration and services
5. ✅ Router with bottom navigation
6. ✅ Shared enums and validators
7. ✅ Error handling patterns
8. ✅ Auth domain layer (entities, repository, use cases)
9. ✅ Auth data layer (Supabase integration)
10. ✅ Auth presentation layer (login, register pages)
11. ✅ App entry point
12. ✅ Font assets

After completing this foundation, subsequent phases will implement:
- Dashboard feature
- Tasks feature
- Habits feature
- Goals feature
- AI Coach feature
- Focus Mode feature
- Analytics feature
- Health tracking feature
- Settings feature
- And all other features from the documentation
