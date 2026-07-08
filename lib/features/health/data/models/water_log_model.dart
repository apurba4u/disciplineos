import '../../domain/entities/water_log.dart';

class WaterLogModel extends WaterLog {
  const WaterLogModel({
    required super.id,
    required super.userId,
    required super.amountMl,
    required super.goalMl,
    required super.loggedAt,
  });

  factory WaterLogModel.fromJson(Map<String, dynamic> json) {
    return WaterLogModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      amountMl: json['amount_ml'] as int,
      goalMl: json['goal_ml'] as int,
      loggedAt: DateTime.parse(json['logged_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amount_ml': amountMl,
      'goal_ml': goalMl,
      'logged_at': loggedAt.toIso8601String(),
    };
  }
}
