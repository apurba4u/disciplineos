enum GoalCategory {
  academic,
  career,
  health,
  fitness,
  finance,
  business,
  personal,
  research;

  String get label {
    switch (this) {
      case GoalCategory.academic:
        return 'Academic';
      case GoalCategory.career:
        return 'Career';
      case GoalCategory.health:
        return 'Health';
      case GoalCategory.fitness:
        return 'Fitness';
      case GoalCategory.finance:
        return 'Finance';
      case GoalCategory.business:
        return 'Business';
      case GoalCategory.personal:
        return 'Personal';
      case GoalCategory.research:
        return 'Research';
    }
  }
}
