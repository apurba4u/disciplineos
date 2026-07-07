import 'package:dartz/dartz.dart' show Either, Right, Left;
import '../../../../core/errors/failures.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<AppNotification>>> getNotifications({
    bool? unreadOnly,
    NotificationType? type,
  }) async {
    try {
      final notifications = await _remoteDataSource.getNotifications(
        unreadOnly: unreadOnly,
        type: type?.name,
      );
      return Right(notifications);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppNotification>> getNotificationById(
    String id,
  ) async {
    try {
      final notification = await _remoteDataSource.getNotificationById(id);
      return Right(notification);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(String id) async {
    try {
      await _remoteDataSource.markAsRead(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    try {
      await _remoteDataSource.markAllAsRead();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(String id) async {
    try {
      await _remoteDataSource.deleteNotification(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearAll() async {
    try {
      await _remoteDataSource.clearAll();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    try {
      final count = await _remoteDataSource.getUnreadCount();
      return Right(count);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> scheduleNotification(
    AppNotification notification,
  ) async {
    try {
      final model = NotificationModel(
        id: notification.id,
        userId: notification.userId,
        title: notification.title,
        body: notification.body,
        type: notification.type,
        scheduledAt: notification.scheduledAt,
        read: notification.read,
        actionUrl: notification.actionUrl,
        data: notification.data,
        createdAt: notification.createdAt,
      );
      await _remoteDataSource.getNotificationById(model.id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelScheduledNotification(String id) async {
    try {
      await _remoteDataSource.deleteNotification(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<AppNotification>> watchNotifications() {
    return _remoteDataSource.watchNotifications();
  }
}
