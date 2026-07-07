import 'ai_provider.dart';
import 'ai_response.dart';

class AIProviderRouter {
  final AIProvider _primaryProvider;
  final AIProvider? _fallbackProvider;

  AIProviderRouter({
    required AIProvider primaryProvider,
    AIProvider? fallbackProvider,
  })  : _primaryProvider = primaryProvider,
        _fallbackProvider = fallbackProvider;

  AIProvider get currentProvider => _primaryProvider;

  Future<AIResponse> executeWithFallback({
    required Future<AIResponse> Function(AIProvider) operation,
  }) async {
    try {
      final result = await operation(_primaryProvider);
      if (result.isSuccess) return result;

      if (_fallbackProvider != null) {
        try {
          final fallbackResult = await operation(_fallbackProvider);
          return fallbackResult;
        } catch (fallbackError) {
          return AIResponse.failure(
            'Both providers failed: ${fallbackError.toString()}',
          );
        }
      }

      return result;
    } catch (e) {
      if (_fallbackProvider != null) {
        try {
          final fallbackResult = await operation(_fallbackProvider);
          return fallbackResult;
        } catch (fallbackError) {
          return AIResponse.failure(
            'Both providers failed: ${fallbackError.toString()}',
          );
        }
      }

      return AIResponse.failure(e.toString());
    }
  }
}
