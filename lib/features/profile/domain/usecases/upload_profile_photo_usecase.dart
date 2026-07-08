import 'dart:io';
import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../repositories/profile_repository.dart';

class UploadProfilePhotoUseCase {
  final ProfileRepository _repository;

  UploadProfilePhotoUseCase(this._repository);

  Future<Either<Failure, String>> call(String userId, File imageFile) {
    return _repository.uploadProfilePhoto(userId, imageFile);
  }
}
