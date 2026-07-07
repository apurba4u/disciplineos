import '../../domain/entities/focus_session.dart';

class FocusSessionModel extends FocusSession {
  const FocusSessionModel({
    required super.id,
    required super.userId,
    required super.type,
    required super.startTime,
    super.endTime,
    required super.durationMinutes,
    super.interruptions,
    super.linkedTaskId,
    super.mood,
    super.notes,
    super.category,
    super.score,
    super.completed,
    required super.createdAt,
  });

  factory FocusSessionModel.fromJson(Map<String, dynamic> json) {
    return FocusSessionModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: FocusModeType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => FocusModeType.custom,
      ),
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] != null
          ? DateTime.parse(json['end_time'] as String)
          : null,
      durationMinutes: json['duration_minutes'] as int,
      interruptions: json['interruptions'] as int? ?? 0,
      linkedTaskId: json['linked_task_id'] as String?,
      mood: json['mood'] as String?,
      notes: json['notes'] as String?,
      category: json['category'] as String?,
      score: json['score'] as int? ?? 0,
      completed: json['completed'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type.name,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'duration_minutes': durationMinutes,
      'interruptions': interruptions,
      'linked_task_id': linkedTaskId,
      'mood': mood,
      'notes': notes,
      'category': category,
      'score': score,
      'completed': completed,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
