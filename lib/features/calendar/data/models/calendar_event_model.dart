import '../../domain/entities/calendar_event.dart';

class CalendarEventModel extends CalendarEvent {
  const CalendarEventModel({
    required super.id,
    required super.userId,
    required super.title,
    super.description,
    super.location,
    required super.startTime,
    required super.endTime,
    super.eventType,
    super.linkedTaskId,
    super.linkedGoalId,
    super.color,
    super.allDay,
    required super.createdAt,
  });

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) {
    return CalendarEventModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      location: json['location'] as String?,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      eventType: EventType.values.firstWhere(
        (e) => e.name == json['event_type'],
        orElse: () => EventType.custom,
      ),
      linkedTaskId: json['linked_task_id'] as String?,
      linkedGoalId: json['linked_goal_id'] as String?,
      color: json['color'] as String?,
      allDay: json['all_day'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'location': location,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'event_type': eventType.name,
      'linked_task_id': linkedTaskId,
      'linked_goal_id': linkedGoalId,
      'color': color,
      'all_day': allDay,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
