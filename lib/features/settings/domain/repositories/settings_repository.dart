import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/user_settings.dart';

abstract class SettingsRepository {
  Future<Either<Failure, UserSettings>> getSettings(String userId);

  Future<Either<Failure, UserSettings>> updateSettings(UserSettings settings);

  Future<Either<Failure, void>> resetSettings(String userId);

  Stream<UserSettings> watchSettings(String userId);
}
