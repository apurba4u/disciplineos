import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/app_notification.dart';
import '../providers/notification_provider.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (state.unreadCount > 0)
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All notifications marked as read')),
                );
              },
              child: const Text('Mark all read'),
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.notifications.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_none, size: 64),
                      SizedBox(height: 16),
                      Text('No notifications'),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];
                    return _NotificationTile(
                      notification: notification,
                      onTap: () {
                        ref.read(notificationProvider.notifier)
                            .markAsRead(notification.id);
                      },
                    );
                  },
                ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: notification.isUnread
            ? Theme.of(context).colorScheme.primary.withAlpha(30)
            : null,
        child: Icon(_getIconForType(notification.type)),
      ),
      title: Text(
        notification.title,
        style: TextStyle(
          fontWeight: notification.isUnread ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(notification.body),
      trailing: Text(
        DateFormat('MMM d, HH:mm').format(notification.createdAt),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: onTap,
    );
  }

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.taskReminder:
        return Icons.task_alt;
      case NotificationType.habitReminder:
        return Icons.check_circle_outline;
      case NotificationType.goalReminder:
        return Icons.flag_outlined;
      case NotificationType.waterReminder:
        return Icons.water_drop_outlined;
      case NotificationType.sleepReminder:
        return Icons.bedtime_outlined;
      case NotificationType.workoutReminder:
        return Icons.fitness_center;
      case NotificationType.focusReminder:
        return Icons.timer_outlined;
      case NotificationType.calendarReminder:
        return Icons.calendar_today;
      case NotificationType.aiRecommendation:
        return Icons.psychology_outlined;
      case NotificationType.systemAlert:
        return Icons.info_outline;
    }
  }
}
