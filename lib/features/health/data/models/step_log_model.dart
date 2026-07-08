import '../../domain/entities/step_log.dart';

class StepLogModel extends StepLog {
  const StepLogModel({
    required super.id,
    required super.userId,
    required super.steps,
    required super.distance,
    required super.calories,
    required super.goal,
    required super.date,
    required super.createdAt,
  });

  factory StepLogModel.fromJson(Map<String, dynamic> json) {
    return StepLogModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      steps: json['steps'] as int,
      distance: (json['distance'] as num).toDouble(),
      calories: json['calories'] as int,
      goal: json['goal'] as int,
      date: DateTime.parse(json['date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'steps': steps,
      'distance': distance,
      'calories': calories,
      'goal': goal,
      'date': date.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
