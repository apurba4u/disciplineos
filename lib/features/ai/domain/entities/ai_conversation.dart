class AIMessage {
  final String id;
  final String role;
  final String content;
  final DateTime timestamp;

  const AIMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
  });

  AIMessage copyWith({
    String? id,
    String? role,
    String? content,
    DateTime? timestamp,
  }) {
    return AIMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  bool get isUser => role == 'user';
  bool get isAssistant => role == 'assistant';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIMessage && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class AIConversation {
  final String id;
  final String userId;
  final String title;
  final List<AIMessage> messages;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AIConversation({
    required this.id,
    required this.userId,
    required this.title,
    this.messages = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  AIConversation copyWith({
    String? id,
    String? userId,
    String? title,
    List<AIMessage>? messages,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AIConversation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      messages: messages ?? this.messages,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  AIMessage? get lastMessage =>
      messages.isNotEmpty ? messages.last : null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIConversation &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
