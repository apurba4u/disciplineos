class TaskValidator {
  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  static String? validateDeadline(DateTime? value) {
    if (value == null) {
      return 'Deadline is required';
    }
    if (value.isBefore(DateTime.now())) {
      return 'Deadline cannot be in the past';
    }
    return null;
  }

  static String? validateEstimatedDuration(int? minutes) {
    if (minutes == null || minutes <= 0) {
      return 'Estimated duration must be greater than 0';
    }
    return null;
  }
}
