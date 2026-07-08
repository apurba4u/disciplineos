class AnalyticsData {
  final double disciplineScore;
  final double productivityScore;
  final double healthScore;
  final double focusScore;
  final double consistencyScore;
  final int totalTasks;
  final int completedTasks;
  final int totalHabits;
  final int completedHabits;
  final int totalFocusMinutes;
  final int totalWaterIntake;
  final DateTime periodStart;
  final DateTime periodEnd;

  const AnalyticsData({
    this.disciplineScore = 0,
    this.productivityScore = 0,
    this.healthScore = 0,
    this.focusScore = 0,
    this.consistencyScore = 0,
    this.totalTasks = 0,
    this.completedTasks = 0,
    this.totalHabits = 0,
    this.completedHabits = 0,
    this.totalFocusMinutes = 0,
    this.totalWaterIntake = 0,
    required this.periodStart,
    required this.periodEnd,
  });

  double get taskCompletionRate =>
      totalTasks == 0 ? 0 : completedTasks / totalTasks;

  double get habitCompletionRate =>
      totalHabits == 0 ? 0 : completedHabits / totalHabits;

  AnalyticsData copyWith({
    double? disciplineScore,
    double? productivityScore,
    double? healthScore,
    double? focusScore,
    double? consistencyScore,
    int? totalTasks,
    int? completedTasks,
    int? totalHabits,
    int? completedHabits,
    int? totalFocusMinutes,
    int? totalWaterIntake,
    DateTime? periodStart,
    DateTime? periodEnd,
  }) {
    return AnalyticsData(
      disciplineScore: disciplineScore ?? this.disciplineScore,
      productivityScore: productivityScore ?? this.productivityScore,
      healthScore: healthScore ?? this.healthScore,
      focusScore: focusScore ?? this.focusScore,
      consistencyScore: consistencyScore ?? this.consistencyScore,
      totalTasks: totalTasks ?? this.totalTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      totalHabits: totalHabits ?? this.totalHabits,
      completedHabits: completedHabits ?? this.completedHabits,
      totalFocusMinutes: totalFocusMinutes ?? this.totalFocusMinutes,
      totalWaterIntake: totalWaterIntake ?? this.totalWaterIntake,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
    );
  }
}

class DailyAnalytics {
  final DateTime date;
  final int tasksCompleted;
  final int habitsCompleted;
  final int focusMinutes;
  final int waterIntake;

  const DailyAnalytics({
    required this.date,
    this.tasksCompleted = 0,
    this.habitsCompleted = 0,
    this.focusMinutes = 0,
    this.waterIntake = 0,
  });
}
