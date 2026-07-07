enum EventType {
  task,
  habit,
  focus,
  meeting,
  reminder,
  custom;

  String get label {
    switch (this) {
      case EventType.task:
        return 'Task';
      case EventType.habit:
        return 'Habit';
      case EventType.focus:
        return 'Focus';
      case EventType.meeting:
        return 'Meeting';
      case EventType.reminder:
        return 'Reminder';
      case EventType.custom:
        return 'Custom';
    }
  }
}

class CalendarEvent {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String? location;
  final DateTime startTime;
  final DateTime endTime;
  final EventType eventType;
  final String? linkedTaskId;
  final String? linkedGoalId;
  final String? color;
  final bool allDay;
  final DateTime createdAt;

  const CalendarEvent({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.location,
    required this.startTime,
    required this.endTime,
    this.eventType = EventType.custom,
    this.linkedTaskId,
    this.linkedGoalId,
    this.color,
    this.allDay = false,
    required this.createdAt,
  });

  CalendarEvent copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? location,
    DateTime? startTime,
    DateTime? endTime,
    EventType? eventType,
    String? linkedTaskId,
    String? linkedGoalId,
    String? color,
    bool? allDay,
    DateTime? createdAt,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      eventType: eventType ?? this.eventType,
      linkedTaskId: linkedTaskId ?? this.linkedTaskId,
      linkedGoalId: linkedGoalId ?? this.linkedGoalId,
      color: color ?? this.color,
      allDay: allDay ?? this.allDay,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Duration get duration => endTime.difference(startTime);

  bool get isToday {
    final now = DateTime.now();
    return startTime.year == now.year &&
        startTime.month == now.month &&
        startTime.day == now.day;
  }

  bool get isPast => endTime.isBefore(DateTime.now());

  bool get isOngoing =>
      startTime.isBefore(DateTime.now()) && endTime.isAfter(DateTime.now());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarEvent &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
