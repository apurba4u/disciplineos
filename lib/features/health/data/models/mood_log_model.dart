import '../../domain/entities/mood_log.dart';

class MoodLogModel extends MoodLog {
  const MoodLogModel({
    required super.id,
    required super.userId,
    required super.mood,
    super.journal,
    required super.createdAt,
  });

  factory MoodLogModel.fromJson(Map<String, dynamic> json) {
    return MoodLogModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      mood: MoodType.values.firstWhere(
        (e) => e.name == json['mood'],
        orElse: () => MoodType.neutral,
      ),
      journal: json['journal'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'mood': mood.name,
      'journal': journal,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
