import '../../../../shared/enums/ai_provider.dart';
import '../../../../shared/enums/theme_mode.dart';

class UserSettings {
  final String userId;
  final AppThemeMode themeMode;
  final String? accentColor;
  final String fontFamily;
  final double fontSizeScale;
  final AIProviderType aiProvider;
  final bool notificationsEnabled;
  final bool quietHoursEnabled;
  final String? quietHoursStart;
  final String? quietHoursEnd;
  final bool smartNotifications;
  final bool biometricEnabled;
  final bool pinLockEnabled;
  final String? pinCode;
  final int autoLockMinutes;
  final String language;
  final DateTime updatedAt;

  const UserSettings({
    required this.userId,
    this.themeMode = AppThemeMode.system,
    this.accentColor,
    this.fontFamily = 'Inter',
    this.fontSizeScale = 1.0,
    this.aiProvider = AIProviderType.gemini,
    this.notificationsEnabled = true,
    this.quietHoursEnabled = false,
    this.quietHoursStart,
    this.quietHoursEnd,
    this.smartNotifications = true,
    this.biometricEnabled = false,
    this.pinLockEnabled = false,
    this.pinCode,
    this.autoLockMinutes = 5,
    this.language = 'en',
    required this.updatedAt,
  });

  UserSettings copyWith({
    String? userId,
    AppThemeMode? themeMode,
    String? accentColor,
    String? fontFamily,
    double? fontSizeScale,
    AIProviderType? aiProvider,
    bool? notificationsEnabled,
    bool? quietHoursEnabled,
    String? quietHoursStart,
    String? quietHoursEnd,
    bool? smartNotifications,
    bool? biometricEnabled,
    bool? pinLockEnabled,
    String? pinCode,
    int? autoLockMinutes,
    String? language,
    DateTime? updatedAt,
  }) {
    return UserSettings(
      userId: userId ?? this.userId,
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSizeScale: fontSizeScale ?? this.fontSizeScale,
      aiProvider: aiProvider ?? this.aiProvider,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      quietHoursEnabled: quietHoursEnabled ?? this.quietHoursEnabled,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
      smartNotifications: smartNotifications ?? this.smartNotifications,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      pinLockEnabled: pinLockEnabled ?? this.pinLockEnabled,
      pinCode: pinCode ?? this.pinCode,
      autoLockMinutes: autoLockMinutes ?? this.autoLockMinutes,
      language: language ?? this.language,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettings &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}
