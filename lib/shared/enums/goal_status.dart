enum GoalStatus {
  notStarted,
  active,
  paused,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case GoalStatus.notStarted:
        return 'Not Started';
      case GoalStatus.active:
        return 'Active';
      case GoalStatus.paused:
        return 'Paused';
      case GoalStatus.completed:
        return 'Completed';
      case GoalStatus.cancelled:
        return 'Cancelled';
    }
  }
}
