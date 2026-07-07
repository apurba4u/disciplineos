enum TaskStatus {
  pending,
  inProgress,
  completed,
  cancelled,
  overdue;

  String get label {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.cancelled:
        return 'Cancelled';
      case TaskStatus.overdue:
        return 'Overdue';
    }
  }
}
