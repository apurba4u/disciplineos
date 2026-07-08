import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/user_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getProfile(String userId);

  Future<Either<Failure, UserProfile>> updateProfile(UserProfile profile);

  Future<Either<Failure, UserProfile>> createProfile(UserProfile profile);

  Future<Either<Failure, void>> deleteProfile(String userId);

  Stream<UserProfile> watchProfile(String userId);
}
