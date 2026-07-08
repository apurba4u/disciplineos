class GamificationService {
  static const Map<String, int> xpRewards = {
    'complete_task': 10,
    'complete_habit': 5,
    'focus_session': 20,
    'workout': 15,
    'water_goal': 5,
    'sleep_goal': 15,
    'weekly_goal': 100,
    'streak_7_days': 50,
    'streak_30_days': 200,
  };

  static const List<Map<String, dynamic>> achievements = [
    {
      'id': 'streak_7',
      'title': '7 Day Streak',
      'description': 'Complete habits for 7 consecutive days',
      'xpReward': 50,
    },
    {
      'id': 'streak_30',
      'title': '30 Day Streak',
      'description': 'Complete habits for 30 consecutive days',
      'xpReward': 200,
    },
    {
      'id': 'tasks_100',
      'title': 'Task Master',
      'description': 'Complete 100 tasks',
      'xpReward': 100,
    },
    {
      'id': 'habits_100',
      'title': 'Habit Hero',
      'description': 'Complete 100 habits',
      'xpReward': 100,
    },
    {
      'id': 'focus_100',
      'title': 'Focus Champion',
      'description': 'Complete 100 focus sessions',
      'xpReward': 150,
    },
    {
      'id': 'perfect_week',
      'title': 'Perfect Week',
      'description': 'Complete all habits for a week',
      'xpReward': 100,
    },
    {
      'id': 'perfect_month',
      'title': 'Perfect Month',
      'description': 'Complete all habits for a month',
      'xpReward': 500,
    },
  ];

  int calculateXpForAction(String action) {
    return xpRewards[action] ?? 0;
  }

  int calculateLevel(int totalXp) {
    return (totalXp / 100).floor() + 1;
  }

  String getTitleForLevel(int level) {
    if (level >= 100) return 'Master';
    if (level >= 50) return 'Elite';
    if (level >= 25) return 'Disciplined';
    if (level >= 10) return 'Consistent';
    return 'Beginner';
  }

  List<String> checkAchievements({
    required int totalTasksCompleted,
    required int totalHabitsCompleted,
    required int totalFocusSessions,
    required int currentStreak,
  }) {
    final newAchievements = <String>[];

    if (currentStreak >= 7) {
      newAchievements.add('streak_7');
    }
    if (currentStreak >= 30) {
      newAchievements.add('streak_30');
    }
    if (totalTasksCompleted >= 100) {
      newAchievements.add('tasks_100');
    }
    if (totalHabitsCompleted >= 100) {
      newAchievements.add('habits_100');
    }
    if (totalFocusSessions >= 100) {
      newAchievements.add('focus_100');
    }

    return newAchievements;
  }

  Map<String, dynamic> getXpBreakdown({
    required int tasksCompleted,
    required int habitsCompleted,
    required int focusMinutes,
    required int workouts,
    required bool waterGoalMet,
    required bool sleepGoalMet,
  }) {
    int totalXp = 0;
    final breakdown = <String, int>{};

    final taskXp = tasksCompleted * xpRewards['complete_task']!;
    breakdown['Tasks'] = taskXp;
    totalXp += taskXp;

    final habitXp = habitsCompleted * xpRewards['complete_habit']!;
    breakdown['Habits'] = habitXp;
    totalXp += habitXp;

    final focusXp = (focusMinutes ~/ 25) * xpRewards['focus_session']!;
    breakdown['Focus'] = focusXp;
    totalXp += focusXp;

    final workoutXp = workouts * xpRewards['workout']!;
    breakdown['Workouts'] = workoutXp;
    totalXp += workoutXp;

    if (waterGoalMet) {
      breakdown['Water Goal'] = xpRewards['water_goal']!;
      totalXp += xpRewards['water_goal']!;
    }

    if (sleepGoalMet) {
      breakdown['Sleep Goal'] = xpRewards['sleep_goal']!;
      totalXp += xpRewards['sleep_goal']!;
    }

    return {
      'totalXp': totalXp,
      'breakdown': breakdown,
    };
  }
}
