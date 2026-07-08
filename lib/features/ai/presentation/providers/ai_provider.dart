import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/ai_conversation.dart';

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
  AIChatNotifier() : super(const AIChatState());

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

    await Future.delayed(const Duration(seconds: 1));

    final response = AIMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: 'assistant',
      content: 'This is a placeholder response. AI integration will be implemented with Gemini/DeepSeek.',
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
  }

  void clearConversation() {
    state = state.copyWith(currentConversation: null);
  }
}

final aiChatProvider =
    StateNotifierProvider<AIChatNotifier, AIChatState>((ref) {
  return AIChatNotifier();
});
