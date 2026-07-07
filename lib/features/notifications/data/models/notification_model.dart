import '../../domain/entities/app_notification.dart';

class NotificationModel extends AppNotification {
  const NotificationModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
    required super.type,
    required super.scheduledAt,
    super.read,
    super.actionUrl,
    super.data,
    required super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NotificationType.systemAlert,
      ),
      scheduledAt: DateTime.parse(json['scheduled_at'] as String),
      read: json['read'] as bool? ?? false,
      actionUrl: json['action_url'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'body': body,
      'type': type.name,
      'scheduled_at': scheduledAt.toIso8601String(),
      'read': read,
      'action_url': actionUrl,
      'data': data,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
