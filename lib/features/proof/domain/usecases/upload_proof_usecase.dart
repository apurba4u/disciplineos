import 'dart:io';
import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/proof.dart';
import '../repositories/proof_repository.dart';

class UploadProofUseCase {
  final ProofRepository _repository;

  UploadProofUseCase(this._repository);

  Future<Either<Failure, Proof>> call({
    required String taskId,
    required File imageFile,
    required Map<String, dynamic> taskContext,
  }) {
    return _repository.uploadAndVerify(
      taskId: taskId,
      imageFile: imageFile,
      taskContext: taskContext,
    );
  }
}
