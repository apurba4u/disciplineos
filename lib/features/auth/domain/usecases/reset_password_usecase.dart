import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<Either<Failure, void>> call(String email) {
    return _repository.resetPassword(email: email);
  }
}
