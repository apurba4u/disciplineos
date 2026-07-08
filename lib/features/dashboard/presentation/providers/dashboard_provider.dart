import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/dashboard_data.dart';

class DashboardState {
  final DashboardData data;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.data = const DashboardData(),
    this.isLoading = false,
    this.error,
  });

  DashboardState copyWith({
    DashboardData? data,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier() : super(const DashboardState());

  Future<void> loadDashboard() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      state = state.copyWith(
        data: const DashboardData(
          todayTasks: 5,
          completedTasks: 2,
          todayHabits: 4,
          completedHabits: 3,
          activeGoals: 3,
          totalFocusMinutes: 45,
          waterIntake: 1500,
          disciplineScore: 78,
          productivityScore: 82,
          healthScore: 75,
          aiSummary: 'Good progress today! You completed 2 tasks and 3 habits.',
          quoteOfTheDay: 'Discipline is the bridge between goals and accomplishment.',
        ),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    await loadDashboard();
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier()..loadDashboard();
});
