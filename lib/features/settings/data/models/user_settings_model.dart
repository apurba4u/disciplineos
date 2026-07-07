import '../../../../shared/enums/ai_provider.dart';
import '../../../../shared/enums/theme_mode.dart';
import '../../domain/entities/user_settings.dart';

class UserSettingsModel extends UserSettings {
  const UserSettingsModel({
    required super.userId,
    super.themeMode,
    super.accentColor,
    super.fontFamily,
    super.fontSizeScale,
    super.aiProvider,
    super.notificationsEnabled,
    super.quietHoursEnabled,
    super.quietHoursStart,
    super.quietHoursEnd,
    super.smartNotifications,
    super.biometricEnabled,
    super.pinLockEnabled,
    super.pinCode,
    super.autoLockMinutes,
    super.language,
    required super.updatedAt,
  });

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsModel(
      userId: json['user_id'] as String,
      themeMode: AppThemeMode.values.firstWhere(
        (e) => e.name == json['theme_mode'],
        orElse: () => AppThemeMode.system,
      ),
      accentColor: json['accent_color'] as String?,
      fontFamily: json['font_family'] as String? ?? 'Inter',
      fontSizeScale: (json['font_size_scale'] as num?)?.toDouble() ?? 1.0,
      aiProvider: AIProviderType.values.firstWhere(
        (e) => e.name == json['ai_provider'],
        orElse: () => AIProviderType.gemini,
      ),
      notificationsEnabled: json['notifications_enabled'] as bool? ?? true,
      quietHoursEnabled: json['quiet_hours_enabled'] as bool? ?? false,
      quietHoursStart: json['quiet_hours_start'] as String?,
      quietHoursEnd: json['quiet_hours_end'] as String?,
      smartNotifications: json['smart_notifications'] as bool? ?? true,
      biometricEnabled: json['biometric_enabled'] as bool? ?? false,
      pinLockEnabled: json['pin_lock_enabled'] as bool? ?? false,
      pinCode: json['pin_code'] as String?,
      autoLockMinutes: json['auto_lock_minutes'] as int? ?? 5,
      language: json['language'] as String? ?? 'en',
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'theme_mode': themeMode.name,
      'accent_color': accentColor,
      'font_family': fontFamily,
      'font_size_scale': fontSizeScale,
      'ai_provider': aiProvider.name,
      'notifications_enabled': notificationsEnabled,
      'quiet_hours_enabled': quietHoursEnabled,
      'quiet_hours_start': quietHoursStart,
      'quiet_hours_end': quietHoursEnd,
      'smart_notifications': smartNotifications,
      'biometric_enabled': biometricEnabled,
      'pin_lock_enabled': pinLockEnabled,
      'pin_code': pinCode,
      'auto_lock_minutes': autoLockMinutes,
      'language': language,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
