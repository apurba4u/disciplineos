import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/habit.dart';
import '../../domain/usecases/get_habits_usecase.dart';
import '../../domain/usecases/create_habit_usecase.dart';
import '../../domain/usecases/log_habit_completion_usecase.dart';

class HabitState {
  final List<Habit> habits;
  final bool isLoading;
  final String? error;

  const HabitState({
    this.habits = const [],
    this.isLoading = false,
    this.error,
  });

  HabitState copyWith({
    List<Habit>? habits,
    bool? isLoading,
    String? error,
  }) {
    return HabitState(
      habits: habits ?? this.habits,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<Habit> get activeHabits => habits.where((h) => h.isActive).toList();

  int get completedToday => 0;
}

class HabitNotifier extends StateNotifier<HabitState> {
  final GetHabitsUseCase _getHabitsUseCase;
  final CreateHabitUseCase _createHabitUseCase;
  final LogHabitCompletionUseCase _logHabitCompletionUseCase;

  HabitNotifier({
    required GetHabitsUseCase getHabitsUseCase,
    required CreateHabitUseCase createHabitUseCase,
    required LogHabitCompletionUseCase logHabitCompletionUseCase,
  })  : _getHabitsUseCase = getHabitsUseCase,
        _createHabitUseCase = createHabitUseCase,
        _logHabitCompletionUseCase = logHabitCompletionUseCase,
        super(const HabitState());

  Future<void> loadHabits() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _getHabitsUseCase();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (habits) => state = state.copyWith(
        habits: habits,
        isLoading: false,
      ),
    );
  }

  Future<void> createHabit(Habit habit) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _createHabitUseCase(habit);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (created) {
        state = state.copyWith(
          habits: [...state.habits, created],
          isLoading: false,
        );
      },
    );
  }

  Future<void> completeHabit(String habitId) async {
    final result = await _logHabitCompletionUseCase(habitId, 1, null);
    result.fold(
      (failure) => state = state.copyWith(error: failure.message),
      (log) {
        final updated = state.habits.map((h) {
          if (h.id == habitId) {
            return h.copyWith(
              currentStreak: h.currentStreak + 1,
              completionRate: h.completionRate + 1,
            );
          }
          return h;
        }).toList();
        state = state.copyWith(habits: updated);
      },
    );
  }
}

final habitProvider =
    StateNotifierProvider<HabitNotifier, HabitState>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});
