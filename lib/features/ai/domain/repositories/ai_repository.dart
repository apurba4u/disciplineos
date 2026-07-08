import 'package:dartz/dartz.dart' show Either;
import '../../../../core/ai/ai_response.dart';
import '../../../../core/errors/failures.dart';
import '../entities/ai_conversation.dart';

abstract class AIRepository {
  Future<Either<Failure, AIResponse>> chat({
    required String message,
    required Map<String, dynamic> context,
  });

  Future<Either<Failure, AIResponse>> generatePlan({
    required String type,
    required Map<String, dynamic> context,
  });

  Future<Either<Failure, AIResponse>> analyze({
    required String analysisType,
    required Map<String, dynamic> context,
  });

  Future<Either<Failure, List<AIConversation>>> getConversations();

  Future<Either<Failure, AIConversation>> getConversation(String id);

  Future<Either<Failure, AIConversation>> createConversation(String title);

  Future<Either<Failure, AIConversation>> sendMessage(
    String conversationId,
    String message,
  );

  Stream<List<AIConversation>> watchConversations();
}
