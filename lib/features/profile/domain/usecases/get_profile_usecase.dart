import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Either<Failure, UserProfile>> call(String userId) {
    return _repository.getProfile(userId);
  }
}
