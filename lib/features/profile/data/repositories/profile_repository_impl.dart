import 'dart:io';
import 'package:dartz/dartz.dart' show Either, Right, Left;
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';
import '../datasources/profile_storage_datasource.dart';
import '../models/user_profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final ProfileStorageDataSource _storageDataSource;

  ProfileRepositoryImpl(this._remoteDataSource, this._storageDataSource);

  @override
  Future<Either<Failure, UserProfile>> getProfile(String userId) async {
    try {
      final profile = await _remoteDataSource.getProfile(userId);
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateProfile(
    UserProfile profile,
  ) async {
    try {
      final model = UserProfileModel(
        id: profile.id,
        userId: profile.userId,
        name: profile.name,
        email: profile.email,
        photoUrl: profile.photoUrl,
        gender: profile.gender,
        dateOfBirth: profile.dateOfBirth,
        height: profile.height,
        weight: profile.weight,
        occupation: profile.occupation,
        timezone: profile.timezone,
        language: profile.language,
        country: profile.country,
        goals: profile.goals,
        createdAt: profile.createdAt,
        updatedAt: DateTime.now(),
      );
      final updated = await _remoteDataSource.updateProfile(model);
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> createProfile(
    UserProfile profile,
  ) async {
    try {
      final model = UserProfileModel(
        id: profile.id,
        userId: profile.userId,
        name: profile.name,
        email: profile.email,
        photoUrl: profile.photoUrl,
        gender: profile.gender,
        dateOfBirth: profile.dateOfBirth,
        height: profile.height,
        weight: profile.weight,
        occupation: profile.occupation,
        timezone: profile.timezone,
        language: profile.language,
        country: profile.country,
        goals: profile.goals,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final created = await _remoteDataSource.createProfile(model);
      return Right(created);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfile(String userId) async {
    try {
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<UserProfile> watchProfile(String userId) {
    return _remoteDataSource.watchProfile(userId);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePhoto(
    String userId,
    File imageFile,
  ) async {
    try {
      final url = await _storageDataSource.uploadProfilePhoto(userId, imageFile);
      return Right(url);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
