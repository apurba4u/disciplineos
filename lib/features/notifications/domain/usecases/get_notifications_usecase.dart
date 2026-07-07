import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/app_notification.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository _repository;

  GetNotificationsUseCase(this._repository);

  Future<Either<Failure, List<AppNotification>>> call({
    bool? unreadOnly,
    NotificationType? type,
  }) {
    return _repository.getNotifications(
      unreadOnly: unreadOnly,
      type: type,
    );
  }
}
