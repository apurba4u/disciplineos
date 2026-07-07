import '../../../../shared/enums/habit_frequency.dart';

class Habit {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String? category;
  final HabitFrequency frequency;
  final int target;
  final String unit;
  final String? reminderTime;
  final int currentStreak;
  final int longestStreak;
  final double completionRate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Habit({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.category,
    this.frequency = HabitFrequency.daily,
    this.target = 1,
    this.unit = 'times',
    this.reminderTime,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.completionRate = 0,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  Habit copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? category,
    HabitFrequency? frequency,
    int? target,
    String? unit,
    String? reminderTime,
    int? currentStreak,
    int? longestStreak,
    double? completionRate,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Habit(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      frequency: frequency ?? this.frequency,
      target: target ?? this.target,
      unit: unit ?? this.unit,
      reminderTime: reminderTime ?? this.reminderTime,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      completionRate: completionRate ?? this.completionRate,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Habit && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
