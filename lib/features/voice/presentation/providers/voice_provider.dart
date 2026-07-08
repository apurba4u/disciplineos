import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/voice_command.dart';

class VoiceState {
  final bool isListening;
  final String recognizedText;
  final VoiceCommand? lastCommand;
  final bool isProcessing;
  final String? error;

  const VoiceState({
    this.isListening = false,
    this.recognizedText = '',
    this.lastCommand,
    this.isProcessing = false,
    this.error,
  });

  VoiceState copyWith({
    bool? isListening,
    String? recognizedText,
    VoiceCommand? lastCommand,
    bool? isProcessing,
    String? error,
  }) {
    return VoiceState(
      isListening: isListening ?? this.isListening,
      recognizedText: recognizedText ?? this.recognizedText,
      lastCommand: lastCommand ?? this.lastCommand,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error,
    );
  }
}

class VoiceNotifier extends StateNotifier<VoiceState> {
  VoiceNotifier() : super(const VoiceState());

  void startListening() {
    state = state.copyWith(isListening: true, error: null);
  }

  void stopListening() {
    state = state.copyWith(isListening: false);
  }

  void updateRecognizedText(String text) {
    state = state.copyWith(recognizedText: text);
  }

  void processCommand(VoiceCommand command) {
    state = state.copyWith(
      lastCommand: command,
      isProcessing: false,
      recognizedText: '',
    );
  }

  void setError(String error) {
    state = state.copyWith(
      error: error,
      isListening: false,
      isProcessing: false,
    );
  }
}

final voiceProvider =
    StateNotifierProvider<VoiceNotifier, VoiceState>((ref) {
  return VoiceNotifier();
});
