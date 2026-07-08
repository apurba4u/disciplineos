import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/enums/goal_status.dart';
import '../../domain/entities/goal.dart';
import '../../domain/usecases/get_goals_usecase.dart';
import '../../domain/usecases/create_goal_usecase.dart';

class GoalState {
  final List<Goal> goals;
  final bool isLoading;
  final String? error;

  const GoalState({
    this.goals = const [],
    this.isLoading = false,
    this.error,
  });

  GoalState copyWith({
    List<Goal>? goals,
    bool? isLoading,
    String? error,
  }) {
    return GoalState(
      goals: goals ?? this.goals,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<Goal> get activeGoals => goals
      .where((g) => g.status == GoalStatus.active)
      .toList();

  List<Goal> get completedGoals => goals
      .where((g) => g.status == GoalStatus.completed)
      .toList();
}

class GoalNotifier extends StateNotifier<GoalState> {
  final GetGoalsUseCase _getGoalsUseCase;
  final CreateGoalUseCase _createGoalUseCase;

  GoalNotifier({
    required GetGoalsUseCase getGoalsUseCase,
    required CreateGoalUseCase createGoalUseCase,
  })  : _getGoalsUseCase = getGoalsUseCase,
        _createGoalUseCase = createGoalUseCase,
        super(const GoalState());

  Future<void> loadGoals() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _getGoalsUseCase();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (goals) => state = state.copyWith(
        goals: goals,
        isLoading: false,
      ),
    );
  }

  Future<void> createGoal(Goal goal) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _createGoalUseCase(goal);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (created) {
        state = state.copyWith(
          goals: [...state.goals, created],
          isLoading: false,
        );
      },
    );
  }
}

final goalProvider =
    StateNotifierProvider<GoalNotifier, GoalState>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});
