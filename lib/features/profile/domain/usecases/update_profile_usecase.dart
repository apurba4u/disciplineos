import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<Either<Failure, UserProfile>> call(UserProfile profile) {
    return _repository.updateProfile(profile);
  }
}
