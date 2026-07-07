import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/app_notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<AppNotification>>> getNotifications({
    bool? unreadOnly,
    NotificationType? type,
  });

  Future<Either<Failure, AppNotification>> getNotificationById(String id);

  Future<Either<Failure, void>> markAsRead(String id);

  Future<Either<Failure, void>> markAllAsRead();

  Future<Either<Failure, void>> deleteNotification(String id);

  Future<Either<Failure, void>> clearAll();

  Future<Either<Failure, int>> getUnreadCount();

  Future<Either<Failure, void>> scheduleNotification(
    AppNotification notification,
  );

  Future<Either<Failure, void>> cancelScheduledNotification(String id);

  Stream<List<AppNotification>> watchNotifications();
}
