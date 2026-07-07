import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/proof.dart';
import '../../domain/usecases/upload_proof_usecase.dart';

class ProofState {
  final List<Proof> proofs;
  final bool isUploading;
  final Proof? lastVerification;
  final String? error;

  const ProofState({
    this.proofs = const [],
    this.isUploading = false,
    this.lastVerification,
    this.error,
  });

  ProofState copyWith({
    List<Proof>? proofs,
    bool? isUploading,
    Proof? lastVerification,
    String? error,
  }) {
    return ProofState(
      proofs: proofs ?? this.proofs,
      isUploading: isUploading ?? this.isUploading,
      lastVerification: lastVerification ?? this.lastVerification,
      error: error,
    );
  }
}

class ProofNotifier extends StateNotifier<ProofState> {
  final UploadProofUseCase _uploadProofUseCase;

  ProofNotifier(this._uploadProofUseCase) : super(const ProofState());

  Future<void> uploadProof({
    required String taskId,
    required File imageFile,
    required Map<String, dynamic> taskContext,
  }) async {
    state = state.copyWith(isUploading: true, error: null);
    final result = await _uploadProofUseCase(
      taskId: taskId,
      imageFile: imageFile,
      taskContext: taskContext,
    );
    result.fold(
      (failure) => state = state.copyWith(
        isUploading: false,
        error: failure.message,
      ),
      (proof) => state = state.copyWith(
        proofs: [...state.proofs, proof],
        lastVerification: proof,
        isUploading: false,
      ),
    );
  }

  void clearLastVerification() {
    state = state.copyWith(lastVerification: null);
  }
}

final proofProvider =
    StateNotifierProvider<ProofNotifier, ProofState>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});
