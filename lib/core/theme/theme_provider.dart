import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_theme.dart' as theme;

enum ThemeType { light, dark, amoled, highContrast }

class ThemeState {
  final ThemeType themeType;
  final Color? accentColor;

  const ThemeState({
    this.themeType = ThemeType.light,
    this.accentColor,
  });

  ThemeState copyWith({
    ThemeType? themeType,
    Color? accentColor,
  }) {
    return ThemeState(
      themeType: themeType ?? this.themeType,
      accentColor: accentColor ?? this.accentColor,
    );
  }

  ThemeData get themeData {
    switch (themeType) {
      case ThemeType.light:
        return theme.AppTheme.lightTheme(accentColor: accentColor);
      case ThemeType.dark:
        return theme.AppTheme.darkTheme(accentColor: accentColor);
      case ThemeType.amoled:
        return theme.AppTheme.amoledTheme(accentColor: accentColor);
      case ThemeType.highContrast:
        return theme.AppTheme.highContrastTheme(accentColor: accentColor);
    }
  }

  ThemeMode get themeMode {
    switch (themeType) {
      case ThemeType.light:
        return ThemeMode.light;
      case ThemeType.dark:
      case ThemeType.amoled:
      case ThemeType.highContrast:
        return ThemeMode.dark;
    }
  }
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(const ThemeState());

  void setTheme(ThemeType themeType) {
    state = state.copyWith(themeType: themeType);
  }

  void setAccentColor(Color color) {
    state = state.copyWith(accentColor: color);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});
