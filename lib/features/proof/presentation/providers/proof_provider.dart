import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ai/ai_provider_router.dart';
import '../../../../core/ai/gemini_provider.dart';
import '../../../../core/ai/deepseek_provider.dart';
import '../../domain/entities/proof.dart';
import '../../domain/usecases/upload_proof_usecase.dart';

final proofAIProviderRouterProvider = Provider<AIProviderRouter>((ref) {
  return AIProviderRouter(
    primaryProvider: GeminiProvider(),
    fallbackProvider: DeepSeekProvider(),
  );
});

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
  final AIProviderRouter _aiRouter;

  ProofNotifier(this._uploadProofUseCase, this._aiRouter)
      : super(const ProofState());

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

  Future<void> verifyWithAI({
    required String imageUrl,
    required Map<String, dynamic> taskContext,
  }) async {
    state = state.copyWith(isUploading: true, error: null);
    try {
      final result = await _aiRouter.executeWithFallback(
        operation: (provider) => provider.verifyProof(
          imageUrl: imageUrl,
          taskContext: taskContext,
        ),
      );

      if (result.isSuccess) {
        final proof = Proof(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          taskId: taskContext['task_id'] as String? ?? '',
          userId: '',
          storagePath: imageUrl,
          imageUrl: imageUrl,
          aiProvider: result.status,
          confidenceScore: (result.confidence ?? 0).toInt(),
          verificationStatus: VerificationStatus.values.firstWhere(
            (s) => s.name == (result.summary ?? 'uncertain'),
            orElse: () => VerificationStatus.uncertain,
          ),
          reasoning: result.summary,
          createdAt: DateTime.now(),
        );
        state = state.copyWith(
          proofs: [...state.proofs, proof],
          lastVerification: proof,
          isUploading: false,
        );
      } else {
        state = state.copyWith(
          isUploading: false,
          error: result.error ?? 'Verification failed',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isUploading: false,
        error: e.toString(),
      );
    }
  }

  void clearLastVerification() {
    state = state.copyWith(lastVerification: null);
  }
}

final proofProvider =
    StateNotifierProvider<ProofNotifier, ProofState>((ref) {
  final uploadUseCase = ref.watch(uploadProofUseCaseProvider);
  final aiRouter = ref.watch(proofAIProviderRouterProvider);
  return ProofNotifier(uploadUseCase, aiRouter);
});

final uploadProofUseCaseProvider = Provider<UploadProofUseCase>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});
