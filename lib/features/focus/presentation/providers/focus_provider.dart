import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/focus_session.dart';

class FocusState {
  final FocusSession? activeSession;
  final int remainingSeconds;
  final bool isRunning;
  final bool isPaused;
  final List<FocusSession> todaySessions;
  final int todayFocusMinutes;
  final bool isLoading;
  final String? error;

  const FocusState({
    this.activeSession,
    this.remainingSeconds = 0,
    this.isRunning = false,
    this.isPaused = false,
    this.todaySessions = const [],
    this.todayFocusMinutes = 0,
    this.isLoading = false,
    this.error,
  });

  FocusState copyWith({
    FocusSession? activeSession,
    int? remainingSeconds,
    bool? isRunning,
    bool? isPaused,
    List<FocusSession>? todaySessions,
    int? todayFocusMinutes,
    bool? isLoading,
    String? error,
  }) {
    return FocusState(
      activeSession: activeSession ?? this.activeSession,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
      isPaused: isPaused ?? this.isPaused,
      todaySessions: todaySessions ?? this.todaySessions,
      todayFocusMinutes: todayFocusMinutes ?? this.todayFocusMinutes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

class FocusNotifier extends StateNotifier<FocusState> {
  Timer? _timer;

  FocusNotifier()
      : super(const FocusState());

  void startSession(FocusModeType type, int durationMinutes) {
    _timer?.cancel();
    state = state.copyWith(
      remainingSeconds: durationMinutes * 60,
      isRunning: true,
      isPaused: false,
    );
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0 && state.isRunning && !state.isPaused) {
        state = state.copyWith(
          remainingSeconds: state.remainingSeconds - 1,
        );
      } else if (state.remainingSeconds == 0 && state.isRunning) {
        pauseSession();
      }
    });
  }

  void pauseSession() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false, isPaused: true);
  }

  void resumeSession() {
    state = state.copyWith(isRunning: true, isPaused: false);
    _startTimer();
  }

  void stopSession() {
    _timer?.cancel();
    state = state.copyWith(
      isRunning: false,
      isPaused: false,
      remainingSeconds: 0,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
