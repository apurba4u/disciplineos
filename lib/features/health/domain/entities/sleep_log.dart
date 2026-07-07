enum SleepQuality {
  excellent,
  good,
  fair,
  poor;

  String get label {
    switch (this) {
      case SleepQuality.excellent:
        return 'Excellent';
      case SleepQuality.good:
        return 'Good';
      case SleepQuality.fair:
        return 'Fair';
      case SleepQuality.poor:
        return 'Poor';
    }
  }
}

class SleepLog {
  final String id;
  final String userId;
  final DateTime sleepStart;
  final DateTime sleepEnd;
  final int durationMinutes;
  final SleepQuality quality;
  final String source;
  final DateTime date;

  const SleepLog({
    required this.id,
    required this.userId,
    required this.sleepStart,
    required this.sleepEnd,
    required this.durationMinutes,
    required this.quality,
    required this.source,
    required this.date,
  });

  SleepLog copyWith({
    String? id,
    String? userId,
    DateTime? sleepStart,
    DateTime? sleepEnd,
    int? durationMinutes,
    SleepQuality? quality,
    String? source,
    DateTime? date,
  }) {
    return SleepLog(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      sleepStart: sleepStart ?? this.sleepStart,
      sleepEnd: sleepEnd ?? this.sleepEnd,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      quality: quality ?? this.quality,
      source: source ?? this.source,
      date: date ?? this.date,
    );
  }

  String get formattedDuration {
    final hours = durationMinutes ~/ 60;
    final minutes = durationMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepLog && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
