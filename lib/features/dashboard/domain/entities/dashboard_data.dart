class DashboardData {
  final int todayTasks;
  final int completedTasks;
  final int todayHabits;
  final int completedHabits;
  final int activeGoals;
  final int totalFocusMinutes;
  final int waterIntake;
  final double disciplineScore;
  final double productivityScore;
  final double healthScore;
  final String? aiSummary;
  final String? quoteOfTheDay;

  const DashboardData({
    this.todayTasks = 0,
    this.completedTasks = 0,
    this.todayHabits = 0,
    this.completedHabits = 0,
    this.activeGoals = 0,
    this.totalFocusMinutes = 0,
    this.waterIntake = 0,
    this.disciplineScore = 0,
    this.productivityScore = 0,
    this.healthScore = 0,
    this.aiSummary,
    this.quoteOfTheDay,
  });

  DashboardData copyWith({
    int? todayTasks,
    int? completedTasks,
    int? todayHabits,
    int? completedHabits,
    int? activeGoals,
    int? totalFocusMinutes,
    int? waterIntake,
    double? disciplineScore,
    double? productivityScore,
    double? healthScore,
    String? aiSummary,
    String? quoteOfTheDay,
  }) {
    return DashboardData(
      todayTasks: todayTasks ?? this.todayTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      todayHabits: todayHabits ?? this.todayHabits,
      completedHabits: completedHabits ?? this.completedHabits,
      activeGoals: activeGoals ?? this.activeGoals,
      totalFocusMinutes: totalFocusMinutes ?? this.totalFocusMinutes,
      waterIntake: waterIntake ?? this.waterIntake,
      disciplineScore: disciplineScore ?? this.disciplineScore,
      productivityScore: productivityScore ?? this.productivityScore,
      healthScore: healthScore ?? this.healthScore,
      aiSummary: aiSummary ?? this.aiSummary,
      quoteOfTheDay: quoteOfTheDay ?? this.quoteOfTheDay,
    );
  }

  double get taskCompletionRate =>
      todayTasks == 0 ? 0 : completedTasks / todayTasks;

  double get habitCompletionRate =>
      todayHabits == 0 ? 0 : completedHabits / todayHabits;
}
