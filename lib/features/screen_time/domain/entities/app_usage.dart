enum AppCategory {
  productivity,
  education,
  entertainment,
  gaming,
  socialMedia,
  communication,
  finance,
  shopping,
  utilities,
  health,
  others;

  String get label {
    switch (this) {
      case AppCategory.productivity:
        return 'Productivity';
      case AppCategory.education:
        return 'Education';
      case AppCategory.entertainment:
        return 'Entertainment';
      case AppCategory.gaming:
        return 'Gaming';
      case AppCategory.socialMedia:
        return 'Social Media';
      case AppCategory.communication:
        return 'Communication';
      case AppCategory.finance:
        return 'Finance';
      case AppCategory.shopping:
        return 'Shopping';
      case AppCategory.utilities:
        return 'Utilities';
      case AppCategory.health:
        return 'Health';
      case AppCategory.others:
        return 'Others';
    }
  }
}

class AppUsage {
  final String id;
  final String userId;
  final String packageName;
  final String appName;
  final AppCategory category;
  final int durationSeconds;
  final int launchCount;
  final DateTime date;
  final DateTime createdAt;

  const AppUsage({
    required this.id,
    required this.userId,
    required this.packageName,
    required this.appName,
    required this.category,
    required this.durationSeconds,
    required this.launchCount,
    required this.date,
    required this.createdAt,
  });

  AppUsage copyWith({
    String? id,
    String? userId,
    String? packageName,
    String? appName,
    AppCategory? category,
    int? durationSeconds,
    int? launchCount,
    DateTime? date,
    DateTime? createdAt,
  }) {
    return AppUsage(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      packageName: packageName ?? this.packageName,
      appName: appName ?? this.appName,
      category: category ?? this.category,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      launchCount: launchCount ?? this.launchCount,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  int get durationMinutes => durationSeconds ~/ 60;

  String get formattedDuration {
    final hours = durationSeconds ~/ 3600;
    final minutes = (durationSeconds % 3600) ~/ 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUsage && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class ScreenTimeData {
  final String userId;
  final int totalMinutes;
  final int productiveMinutes;
  final int distractingMinutes;
  final DateTime date;
  final List<AppUsage> appUsages;

  const ScreenTimeData({
    required this.userId,
    required this.totalMinutes,
    required this.productiveMinutes,
    required this.distractingMinutes,
    required this.date,
    this.appUsages = const [],
  });

  double get productivityRatio =>
      totalMinutes == 0 ? 0 : productiveMinutes / totalMinutes;

  double get distractionRatio =>
      totalMinutes == 0 ? 0 : distractingMinutes / totalMinutes;

  String get formattedTotal {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    return '${hours}h ${minutes}m';
  }
}
