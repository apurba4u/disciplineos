enum MoodType {
  excellent,
  good,
  neutral,
  low,
  bad;

  String get label {
    switch (this) {
      case MoodType.excellent:
        return 'Excellent';
      case MoodType.good:
        return 'Good';
      case MoodType.neutral:
        return 'Neutral';
      case MoodType.low:
        return 'Low';
      case MoodType.bad:
        return 'Bad';
    }
  }

  String get emoji {
    switch (this) {
      case MoodType.excellent:
        return '😄';
      case MoodType.good:
        return '🙂';
      case MoodType.neutral:
        return '😐';
      case MoodType.low:
        return '😔';
      case MoodType.bad:
        return '😢';
    }
  }

  int get value {
    switch (this) {
      case MoodType.excellent:
        return 5;
      case MoodType.good:
        return 4;
      case MoodType.neutral:
        return 3;
      case MoodType.low:
        return 2;
      case MoodType.bad:
        return 1;
    }
  }
}

class MoodLog {
  final String id;
  final String userId;
  final MoodType mood;
  final String? journal;
  final DateTime createdAt;

  const MoodLog({
    required this.id,
    required this.userId,
    required this.mood,
    this.journal,
    required this.createdAt,
  });

  MoodLog copyWith({
    String? id,
    String? userId,
    MoodType? mood,
    String? journal,
    DateTime? createdAt,
  }) {
    return MoodLog(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      mood: mood ?? this.mood,
      journal: journal ?? this.journal,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodLog && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
