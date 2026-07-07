import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/usecases/create_event_usecase.dart';
import '../../domain/usecases/get_events_usecase.dart';

enum CalendarView { day, week, month }

class CalendarState {
  final List<CalendarEvent> events;
  final CalendarView view;
  final DateTime selectedDate;
  final bool isLoading;
  final String? error;

  const CalendarState({
    this.events = const [],
    this.view = CalendarView.month,
    required this.selectedDate,
    this.isLoading = false,
    this.error,
  });

  CalendarState copyWith({
    List<CalendarEvent>? events,
    CalendarView? view,
    DateTime? selectedDate,
    bool? isLoading,
    String? error,
  }) {
    return CalendarState(
      events: events ?? this.events,
      view: view ?? this.view,
      selectedDate: selectedDate ?? this.selectedDate,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<CalendarEvent> get eventsForSelectedDate {
    return events.where((event) {
      return event.startTime.year == selectedDate.year &&
          event.startTime.month == selectedDate.month &&
          event.startTime.day == selectedDate.day;
    }).toList();
  }
}

class CalendarNotifier extends StateNotifier<CalendarState> {
  final GetEventsUseCase _getEventsUseCase;
  final CreateEventUseCase _createEventUseCase;

  CalendarNotifier({
    required GetEventsUseCase getEventsUseCase,
    required CreateEventUseCase createEventUseCase,
  })  : _getEventsUseCase = getEventsUseCase,
        _createEventUseCase = createEventUseCase,
        super(CalendarState(selectedDate: DateTime.now()));

  Future<void> loadEvents() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _getEventsUseCase();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (events) => state = state.copyWith(
        events: events,
        isLoading: false,
      ),
    );
  }

  void setView(CalendarView view) {
    state = state.copyWith(view: view);
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  Future<void> createEvent(CalendarEvent event) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _createEventUseCase(event);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (created) {
        state = state.copyWith(
          events: [...state.events, created],
          isLoading: false,
        );
      },
    );
  }
}
