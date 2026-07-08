import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../../../../core/logger/app_logger.dart';
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
  final SpeechToText _speech = SpeechToText();
  bool _speechInitialized = false;

  VoiceNotifier() : super(const VoiceState());

  Future<void> initialize() async {
    try {
      _speechInitialized = await _speech.initialize(
        onStatus: _onSpeechStatus,
        onError: _onSpeechError,
      );
      if (!_speechInitialized) {
        state = state.copyWith(error: 'Speech recognition not available');
      }
    } catch (e) {
      AppLogger.error('Failed to initialize speech recognition', e);
      state = state.copyWith(error: 'Failed to initialize: ${e.toString()}');
    }
  }

  Future<void> startListening() async {
    if (!_speechInitialized) {
      await initialize();
    }

    if (!_speechInitialized) {
      state = state.copyWith(error: 'Speech recognition not available');
      return;
    }

    try {
      state = state.copyWith(isListening: true, error: null, recognizedText: '');
      await _speech.listen(
        onResult: _onSpeechResult,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        localeId: 'en_US',
      );
    } catch (e) {
      AppLogger.error('Failed to start listening', e);
      state = state.copyWith(
        isListening: false,
        error: 'Failed to start listening: ${e.toString()}',
      );
    }
  }

  Future<void> stopListening() async {
    await _speech.stop();
    state = state.copyWith(isListening: false);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    state = state.copyWith(recognizedText: result.recognizedWords);

    if (result.finalResult) {
      _processRecognizedText(result.recognizedWords);
    }
  }

  void _onSpeechStatus(String status) {
    AppLogger.info('Speech status: $status');
    if (status == 'done' || status == 'notListening') {
      state = state.copyWith(isListening: false);
    }
  }

  void _onSpeechError(dynamic error) {
    AppLogger.error('Speech recognition error', error);
    state = state.copyWith(
      isListening: false,
      error: 'Recognition error: ${error.toString()}',
    );
  }

  void _processRecognizedText(String text) {
    final command = _parseCommand(text);
    if (command != null) {
      state = state.copyWith(
        lastCommand: command,
        isProcessing: false,
        recognizedText: text,
      );
    }
  }

  VoiceCommand? _parseCommand(String text) {
    final lowerText = text.toLowerCase();

    if (lowerText.contains('create task') || lowerText.contains('new task')) {
      return VoiceCommand(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        rawText: text,
        type: VoiceCommandType.createTask,
        timestamp: DateTime.now(),
      );
    }

    if (lowerText.contains('complete task') || lowerText.contains('finish task')) {
      return VoiceCommand(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        rawText: text,
        type: VoiceCommandType.completeTask,
        timestamp: DateTime.now(),
      );
    }

    if (lowerText.contains('start focus') || lowerText.contains('focus mode')) {
      return VoiceCommand(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        rawText: text,
        type: VoiceCommandType.startFocus,
        timestamp: DateTime.now(),
      );
    }

    if (lowerText.contains('stop focus') || lowerText.contains('end focus')) {
      return VoiceCommand(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        rawText: text,
        type: VoiceCommandType.stopFocus,
        timestamp: DateTime.now(),
      );
    }

    if (lowerText.contains('add habit') || lowerText.contains('new habit')) {
      return VoiceCommand(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        rawText: text,
        type: VoiceCommandType.addHabit,
        timestamp: DateTime.now(),
      );
    }

    if (lowerText.contains('log water') || lowerText.contains('drink water')) {
      return VoiceCommand(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        rawText: text,
        type: VoiceCommandType.logWater,
        timestamp: DateTime.now(),
      );
    }

    if (lowerText.contains('ask ai') || lowerText.contains('talk to ai')) {
      return VoiceCommand(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        rawText: text,
        type: VoiceCommandType.askAI,
        timestamp: DateTime.now(),
      );
    }

    if (lowerText.contains('open dashboard') || lowerText.contains('go home')) {
      return VoiceCommand(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        rawText: text,
        type: VoiceCommandType.openDashboard,
        timestamp: DateTime.now(),
      );
    }

    if (lowerText.contains('open calendar') || lowerText.contains('show calendar')) {
      return VoiceCommand(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        rawText: text,
        type: VoiceCommandType.openCalendar,
        timestamp: DateTime.now(),
      );
    }

    return VoiceCommand(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      rawText: text,
      type: VoiceCommandType.unknown,
      timestamp: DateTime.now(),
    );
  }

  void clearCommand() {
    state = state.copyWith(lastCommand: null, recognizedText: '');
  }
}

final voiceProvider =
    StateNotifierProvider<VoiceNotifier, VoiceState>((ref) {
  return VoiceNotifier();
});
