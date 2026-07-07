import 'package:dartz/dartz.dart' show Either, Right, Left;
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_remote_datasource.dart';
import '../models/user_settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource _remoteDataSource;

  SettingsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, UserSettings>> getSettings(String userId) async {
    try {
      final settings = await _remoteDataSource.getSettings(userId);
      return Right(settings);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserSettings>> updateSettings(
    UserSettings settings,
  ) async {
    try {
      final model = UserSettingsModel(
        userId: settings.userId,
        themeMode: settings.themeMode,
        accentColor: settings.accentColor,
        fontFamily: settings.fontFamily,
        fontSizeScale: settings.fontSizeScale,
        aiProvider: settings.aiProvider,
        notificationsEnabled: settings.notificationsEnabled,
        quietHoursEnabled: settings.quietHoursEnabled,
        quietHoursStart: settings.quietHoursStart,
        quietHoursEnd: settings.quietHoursEnd,
        smartNotifications: settings.smartNotifications,
        biometricEnabled: settings.biometricEnabled,
        pinLockEnabled: settings.pinLockEnabled,
        pinCode: settings.pinCode,
        autoLockMinutes: settings.autoLockMinutes,
        language: settings.language,
        updatedAt: DateTime.now(),
      );
      final updated = await _remoteDataSource.updateSettings(model);
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetSettings(String userId) async {
    try {
      final defaultSettings = UserSettingsModel(
        userId: userId,
        updatedAt: DateTime.now(),
      );
      await _remoteDataSource.updateSettings(defaultSettings);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<UserSettings> watchSettings(String userId) {
    return _remoteDataSource.watchSettings(userId);
  }
}
