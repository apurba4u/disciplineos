import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/ai_conversation.dart';
import '../repositories/ai_repository.dart';

class SendMessageUseCase {
  final AIRepository _repository;

  SendMessageUseCase(this._repository);

  Future<Either<Failure, AIConversation>> call(
    String conversationId,
    String message,
  ) {
    return _repository.sendMessage(conversationId, message);
  }
}
