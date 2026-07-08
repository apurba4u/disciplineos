import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/analytics_data.dart';
import '../../domain/usecases/get_analytics_usecase.dart';

class AnalyticsState {
  final AnalyticsData? data;
  final AnalyticsPeriod period;
  final bool isLoading;
  final String? error;

  const AnalyticsState({
    this.data,
    this.period = AnalyticsPeriod.weekly,
    this.isLoading = false,
    this.error,
  });

  AnalyticsState copyWith({
    AnalyticsData? data,
    AnalyticsPeriod? period,
    bool? isLoading,
    String? error,
  }) {
    return AnalyticsState(
      data: data ?? this.data,
      period: period ?? this.period,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AnalyticsNotifier extends StateNotifier<AnalyticsState> {
  final GetAnalyticsUseCase _getAnalyticsUseCase;

  AnalyticsNotifier(this._getAnalyticsUseCase) : super(const AnalyticsState());

  Future<void> loadAnalytics() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _getAnalyticsUseCase(state.period);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (data) => state = state.copyWith(
        data: data,
        isLoading: false,
      ),
    );
  }

  void setPeriod(AnalyticsPeriod period) {
    state = state.copyWith(period: period);
    loadAnalytics();
  }
}

final analyticsProvider =
    StateNotifierProvider<AnalyticsNotifier, AnalyticsState>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});
