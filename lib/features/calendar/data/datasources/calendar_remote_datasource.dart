import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/calendar_event_model.dart';

abstract class CalendarRemoteDataSource {
  Future<List<CalendarEventModel>> getEvents({
    DateTime? startDate,
    DateTime? endDate,
    String? eventType,
  });

  Future<CalendarEventModel> getEventById(String id);

  Future<CalendarEventModel> createEvent(CalendarEventModel event);

  Future<CalendarEventModel> updateEvent(CalendarEventModel event);

  Future<void> deleteEvent(String id);

  Stream<List<CalendarEventModel>> watchEvents();
}

class CalendarRemoteDataSourceImpl implements CalendarRemoteDataSource {
  final SupabaseClient _client;

  CalendarRemoteDataSourceImpl(this._client);

  @override
  Future<List<CalendarEventModel>> getEvents({
    DateTime? startDate,
    DateTime? endDate,
    String? eventType,
  }) async {
    var query = _client.from('calendar_events').select();

    if (startDate != null) {
      query = query.gte('start_time', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('end_time', endDate.toIso8601String());
    }
    if (eventType != null) {
      query = query.eq('event_type', eventType);
    }

    final data = await query.order('start_time');
    return (data as List)
        .map((json) => CalendarEventModel.fromJson(json))
        .toList();
  }

  @override
  Future<CalendarEventModel> getEventById(String id) async {
    final data = await _client
        .from('calendar_events')
        .select()
        .eq('id', id)
        .single();
    return CalendarEventModel.fromJson(data);
  }

  @override
  Future<CalendarEventModel> createEvent(CalendarEventModel event) async {
    final data = await _client
        .from('calendar_events')
        .insert(event.toJson())
        .select()
        .single();
    return CalendarEventModel.fromJson(data);
  }

  @override
  Future<CalendarEventModel> updateEvent(CalendarEventModel event) async {
    final data = await _client
        .from('calendar_events')
        .update(event.toJson())
        .eq('id', event.id)
        .select()
        .single();
    return CalendarEventModel.fromJson(data);
  }

  @override
  Future<void> deleteEvent(String id) async {
    await _client.from('calendar_events').delete().eq('id', id);
  }

  @override
  Stream<List<CalendarEventModel>> watchEvents() {
    return _client
        .from('calendar_events')
        .stream(primaryKey: ['id'])
        .order('start_time')
        .map((data) => data
            .map((json) => CalendarEventModel.fromJson(json))
            .toList());
  }
}
