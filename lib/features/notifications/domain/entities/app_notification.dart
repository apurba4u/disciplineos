enum NotificationType {
  taskReminder,
  habitReminder,
  goalReminder,
  waterReminder,
  sleepReminder,
  workoutReminder,
  focusReminder,
  calendarReminder,
  aiRecommendation,
  systemAlert;

  String get label {
    switch (this) {
      case NotificationType.taskReminder:
        return 'Task Reminder';
      case NotificationType.habitReminder:
        return 'Habit Reminder';
      case NotificationType.goalReminder:
        return 'Goal Reminder';
      case NotificationType.waterReminder:
        return 'Water Reminder';
      case NotificationType.sleepReminder:
        return 'Sleep Reminder';
      case NotificationType.workoutReminder:
        return 'Workout Reminder';
      case NotificationType.focusReminder:
        return 'Focus Reminder';
      case NotificationType.calendarReminder:
        return 'Calendar Reminder';
      case NotificationType.aiRecommendation:
        return 'AI Recommendation';
      case NotificationType.systemAlert:
        return 'System Alert';
    }
  }
}

class AppNotification {
  final String id;
  final String userId;
  final String title;
  final String body;
  final NotificationType type;
  final DateTime scheduledAt;
  final bool read;
  final String? actionUrl;
  final Map<String, dynamic>? data;
  final DateTime createdAt;

  const AppNotification({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.scheduledAt,
    this.read = false,
    this.actionUrl,
    this.data,
    required this.createdAt,
  });

  AppNotification copyWith({
    String? id,
    String? userId,
    String? title,
    String? body,
    NotificationType? type,
    DateTime? scheduledAt,
    bool? read,
    String? actionUrl,
    Map<String, dynamic>? data,
    DateTime? createdAt,
  }) {
    return AppNotification(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      read: read ?? this.read,
      actionUrl: actionUrl ?? this.actionUrl,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isRead => read;

  bool get isUnread => !read;

  bool get isPast => scheduledAt.isBefore(DateTime.now());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppNotification &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
