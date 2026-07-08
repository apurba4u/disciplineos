import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ai/gemini_provider.dart';
import '../../../../core/ai/deepseek_provider.dart';
import '../../../../core/ai/ai_provider_router.dart';
import '../../../../shared/enums/ai_provider.dart';
import '../../domain/entities/ai_conversation.dart';

final aiProviderRouterProvider = Provider<AIProviderRouter>((ref) {
  return AIProviderRouter(
    primaryProvider: GeminiProvider(),
    fallbackProvider: DeepSeekProvider(),
  );
});

final selectedAIProviderProvider = StateProvider<AIProviderType>((ref) {
  return AIProviderType.gemini;
});

class AIChatState {
  final AIConversation? currentConversation;
  final List<AIConversation> conversations;
  final bool isGenerating;
  final String? error;

  const AIChatState({
    this.currentConversation,
    this.conversations = const [],
    this.isGenerating = false,
    this.error,
  });

  AIChatState copyWith({
    AIConversation? currentConversation,
    List<AIConversation>? conversations,
    bool? isGenerating,
    String? error,
  }) {
    return AIChatState(
      currentConversation: currentConversation ?? this.currentConversation,
      conversations: conversations ?? this.conversations,
      isGenerating: isGenerating ?? this.isGenerating,
      error: error,
    );
  }
}

class AIChatNotifier extends StateNotifier<AIChatState> {
  final AIProviderRouter _router;

  AIChatNotifier(this._router) : super(const AIChatState());

  void sendMessage(String message) {
    if (state.currentConversation == null) {
      final conversation = AIConversation(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: '',
        title: message.length > 30 ? '${message.substring(0, 30)}...' : message,
        messages: [
          AIMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            role: 'user',
            content: message,
            timestamp: DateTime.now(),
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      state = state.copyWith(
        currentConversation: conversation,
        conversations: [...state.conversations, conversation],
      );
    } else {
      final updatedMessages = [
        ...state.currentConversation!.messages,
        AIMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          role: 'user',
          content: message,
          timestamp: DateTime.now(),
        ),
      ];
      state = state.copyWith(
        currentConversation: state.currentConversation!.copyWith(
          messages: updatedMessages,
          updatedAt: DateTime.now(),
        ),
      );
    }

    _generateResponse(message);
  }

  Future<void> _generateResponse(String message) async {
    state = state.copyWith(isGenerating: true, error: null);

    try {
      final result = await _router.executeWithFallback(
        operation: (provider) => provider.chat(
          prompt: message,
          context: _buildContext(),
        ),
      );

      final responseContent = result.isSuccess
          ? (result.summary ?? result.message ?? 'No response generated')
          : 'Error: ${result.error ?? "Unknown error"}';

      final response = AIMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        role: 'assistant',
        content: responseContent,
        timestamp: DateTime.now(),
      );

      final updatedMessages = [
        ...state.currentConversation!.messages,
        response,
      ];

      state = state.copyWith(
        currentConversation: state.currentConversation!.copyWith(
          messages: updatedMessages,
          updatedAt: DateTime.now(),
        ),
        isGenerating: false,
      );
    } catch (e) {
      state = state.copyWith(
        isGenerating: false,
        error: e.toString(),
      );
    }
  }

  Map<String, dynamic> _buildContext() {
    return {
      'current_date': DateTime.now().toIso8601String(),
      'app_name': 'Discipline OS',
      'role': 'AI Discipline Coach',
    };
  }

  void clearConversation() {
    state = state.copyWith(currentConversation: null);
  }
}

final aiChatProvider =
    StateNotifierProvider<AIChatNotifier, AIChatState>((ref) {
  final router = ref.watch(aiProviderRouterProvider);
  return AIChatNotifier(router);
});
