import 'dart:io';
import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/proof.dart';

abstract class ProofRepository {
  Future<Either<Failure, Proof>> uploadAndVerify({
    required String taskId,
    required File imageFile,
    required Map<String, dynamic> taskContext,
  });

  Future<Either<Failure, List<Proof>>> getProofsForTask(String taskId);

  Future<Either<Failure, Proof>> getProofById(String id);

  Future<Either<Failure, void>> deleteProof(String id);

  Stream<List<Proof>> watchProofs(String taskId);
}
