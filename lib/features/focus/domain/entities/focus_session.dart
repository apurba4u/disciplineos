enum FocusModeType {
  pomodoro,
  deepWork,
  custom,
  countdown,
  stopwatch;

  String get label {
    switch (this) {
      case FocusModeType.pomodoro:
        return 'Pomodoro';
      case FocusModeType.deepWork:
        return 'Deep Work';
      case FocusModeType.custom:
        return 'Custom';
      case FocusModeType.countdown:
        return 'Countdown';
      case FocusModeType.stopwatch:
        return 'Stopwatch';
    }
  }

  int get defaultDurationMinutes {
    switch (this) {
      case FocusModeType.pomodoro:
        return 25;
      case FocusModeType.deepWork:
        return 90;
      case FocusModeType.custom:
        return 30;
      case FocusModeType.countdown:
        return 30;
      case FocusModeType.stopwatch:
        return 0;
    }
  }
}

class FocusSession {
  final String id;
  final String userId;
  final FocusModeType type;
  final DateTime startTime;
  final DateTime? endTime;
  final int durationMinutes;
  final int interruptions;
  final String? linkedTaskId;
  final String? mood;
  final String? notes;
  final String? category;
  final int score;
  final bool completed;
  final DateTime createdAt;

  const FocusSession({
    required this.id,
    required this.userId,
    required this.type,
    required this.startTime,
    this.endTime,
    required this.durationMinutes,
    this.interruptions = 0,
    this.linkedTaskId,
    this.mood,
    this.notes,
    this.category,
    this.score = 0,
    this.completed = false,
    required this.createdAt,
  });

  FocusSession copyWith({
    String? id,
    String? userId,
    FocusModeType? type,
    DateTime? startTime,
    DateTime? endTime,
    int? durationMinutes,
    int? interruptions,
    String? linkedTaskId,
    String? mood,
    String? notes,
    String? category,
    int? score,
    bool? completed,
    DateTime? createdAt,
  }) {
    return FocusSession(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      interruptions: interruptions ?? this.interruptions,
      linkedTaskId: linkedTaskId ?? this.linkedTaskId,
      mood: mood ?? this.mood,
      notes: notes ?? this.notes,
      category: category ?? this.category,
      score: score ?? this.score,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  int get actualDurationMinutes {
    if (endTime == null) return 0;
    return endTime!.difference(startTime).inMinutes;
  }

  bool get isActive => endTime == null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FocusSession &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
