class Achievement {
  final String id;
  final String title;
  final String description;
  final String? iconUrl;
  final int xpReward;
  final DateTime? earnedAt;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    this.iconUrl,
    required this.xpReward,
    this.earnedAt,
  });

  bool get isEarned => earnedAt != null;

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    String? iconUrl,
    int? xpReward,
    DateTime? earnedAt,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      xpReward: xpReward ?? this.xpReward,
      earnedAt: earnedAt ?? this.earnedAt,
    );
  }
}

class UserProgress {
  final String userId;
  final int totalXp;
  final int level;
  final String title;
  final List<Achievement> achievements;

  const UserProgress({
    required this.userId,
    required this.totalXp,
    required this.level,
    required this.title,
    this.achievements = const [],
  });

  int get xpForNextLevel => (level * 100);

  int get xpProgress => totalXp % 100;

  double get levelProgress => xpProgress / 100;

  UserProgress copyWith({
    String? userId,
    int? totalXp,
    int? level,
    String? title,
    List<Achievement>? achievements,
  }) {
    return UserProgress(
      userId: userId ?? this.userId,
      totalXp: totalXp ?? this.totalXp,
      level: level ?? this.level,
      title: title ?? this.title,
      achievements: achievements ?? this.achievements,
    );
  }
}
