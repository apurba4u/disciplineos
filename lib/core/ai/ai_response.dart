class AIResponse {
  final String status;
  final String? summary;
  final double? confidence;
  final List<String> recommendations;
  final List<AIAction> actions;
  final String? message;
  final String? error;

  const AIResponse({
    required this.status,
    this.summary,
    this.confidence,
    this.recommendations = const [],
    this.actions = const [],
    this.message,
    this.error,
  });

  bool get isSuccess => status == 'success';

  factory AIResponse.success({
    String? summary,
    double? confidence,
    List<String> recommendations = const [],
    List<AIAction> actions = const [],
  }) {
    return AIResponse(
      status: 'success',
      summary: summary,
      confidence: confidence,
      recommendations: recommendations,
      actions: actions,
    );
  }

  factory AIResponse.failure(String error) {
    return AIResponse(
      status: 'error',
      error: error,
    );
  }
}

class AIAction {
  final String type;
  final Map<String, dynamic> data;

  const AIAction({
    required this.type,
    this.data = const {},
  });
}
