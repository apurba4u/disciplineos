import '../../../../shared/enums/habit_frequency.dart';
import '../../domain/entities/habit.dart';

class HabitModel extends Habit {
  const HabitModel({
    required super.id,
    required super.userId,
    required super.title,
    super.description,
    super.category,
    super.frequency,
    super.target,
    super.unit,
    super.reminderTime,
    super.currentStreak,
    super.longestStreak,
    super.completionRate,
    super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      category: json['category'] as String?,
      frequency: HabitFrequency.values.firstWhere(
        (e) => e.name == json['frequency'],
        orElse: () => HabitFrequency.daily,
      ),
      target: json['target'] as int? ?? 1,
      unit: json['unit'] as String? ?? 'times',
      reminderTime: json['reminder_time'] as String?,
      currentStreak: json['current_streak'] as int? ?? 0,
      longestStreak: json['longest_streak'] as int? ?? 0,
      completionRate: (json['completion_rate'] as num?)?.toDouble() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'category': category,
      'frequency': frequency.name,
      'target': target,
      'unit': unit,
      'reminder_time': reminderTime,
      'current_streak': currentStreak,
      'longest_streak': longestStreak,
      'completion_rate': completionRate,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
