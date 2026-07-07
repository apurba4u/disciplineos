import 'ai_response.dart';

abstract class AIProvider {
  String get name;

  Future<AIResponse> chat({
    required String prompt,
    required Map<String, dynamic> context,
  });

  Future<AIResponse> generatePlan({
    required String type,
    required Map<String, dynamic> context,
  });

  Future<AIResponse> analyze({
    required String analysisType,
    required Map<String, dynamic> context,
  });

  Future<AIResponse> verifyProof({
    required String imageUrl,
    required Map<String, dynamic> taskContext,
  });

  Future<AIResponse> summarize({
    required String summaryType,
    required Map<String, dynamic> context,
  });
}
