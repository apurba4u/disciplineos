import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/ai_conversation.dart';
import '../repositories/ai_repository.dart';

class GetConversationsUseCase {
  final AIRepository _repository;

  GetConversationsUseCase(this._repository);

  Future<Either<Failure, List<AIConversation>>> call() {
    return _repository.getConversations();
  }
}
