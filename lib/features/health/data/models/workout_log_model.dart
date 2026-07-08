import '../../domain/entities/workout_log.dart';

class WorkoutLogModel extends WorkoutLog {
  const WorkoutLogModel({
    required super.id,
    required super.userId,
    required super.workoutName,
    required super.durationMinutes,
    required super.calories,
    super.muscleGroup,
    super.notes,
    required super.loggedAt,
  });

  factory WorkoutLogModel.fromJson(Map<String, dynamic> json) {
    return WorkoutLogModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      workoutName: json['workout_name'] as String,
      durationMinutes: json['duration_minutes'] as int,
      calories: json['calories'] as int,
      muscleGroup: json['muscle_group'] as String?,
      notes: json['notes'] as String?,
      loggedAt: DateTime.parse(json['logged_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'workout_name': workoutName,
      'duration_minutes': durationMinutes,
      'calories': calories,
      'muscle_group': muscleGroup,
      'notes': notes,
      'logged_at': loggedAt.toIso8601String(),
    };
  }
}
