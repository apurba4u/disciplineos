class WorkoutLog {
  final String id;
  final String userId;
  final String workoutName;
  final int durationMinutes;
  final int calories;
  final String? muscleGroup;
  final String? notes;
  final DateTime loggedAt;

  const WorkoutLog({
    required this.id,
    required this.userId,
    required this.workoutName,
    required this.durationMinutes,
    required this.calories,
    this.muscleGroup,
    this.notes,
    required this.loggedAt,
  });

  WorkoutLog copyWith({
    String? id,
    String? userId,
    String? workoutName,
    int? durationMinutes,
    int? calories,
    String? muscleGroup,
    String? notes,
    DateTime? loggedAt,
  }) {
    return WorkoutLog(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workoutName: workoutName ?? this.workoutName,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      calories: calories ?? this.calories,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      notes: notes ?? this.notes,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  String get formattedDuration {
    final hours = durationMinutes ~/ 60;
    final minutes = durationMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutLog && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
