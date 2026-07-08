import 'package:dartz/dartz.dart' show Either;
import '../../../../core/ai/ai_response.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/ai_repository.dart';

class ChatUseCase {
  final AIRepository _repository;

  ChatUseCase(this._repository);

  Future<Either<Failure, AIResponse>> call({
    required String message,
    required Map<String, dynamic> context,
  }) {
    return _repository.chat(message: message, context: context);
  }
}
