import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/usecases/get_notifications_usecase.dart';

class NotificationState {
  final List<AppNotification> notifications;
  final int unreadCount;
  final bool isLoading;
  final String? error;

  const NotificationState({
    this.notifications = const [],
    this.unreadCount = 0,
    this.isLoading = false,
    this.error,
  });

  NotificationState copyWith({
    List<AppNotification>? notifications,
    int? unreadCount,
    bool? isLoading,
    String? error,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<AppNotification> get unreadNotifications =>
      notifications.where((n) => n.isUnread).toList();
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  final GetNotificationsUseCase _getNotificationsUseCase;

  NotificationNotifier(this._getNotificationsUseCase)
      : super(const NotificationState());

  Future<void> loadNotifications() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _getNotificationsUseCase();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (notifications) => state = state.copyWith(
        notifications: notifications,
        unreadCount: notifications.where((n) => n.isUnread).length,
        isLoading: false,
      ),
    );
  }

  void markAsRead(String id) {
    final updated = state.notifications.map((n) {
      if (n.id == id) return n.copyWith(read: true);
      return n;
    }).toList();
    state = state.copyWith(
      notifications: updated,
      unreadCount: updated.where((n) => n.isUnread).length,
    );
  }
}

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});
