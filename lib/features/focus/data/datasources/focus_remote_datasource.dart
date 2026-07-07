import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/focus_session_model.dart';

abstract class FocusRemoteDataSource {
  Future<List<FocusSessionModel>> getSessions({
    DateTime? startDate,
    DateTime? endDate,
    String? type,
  });

  Future<FocusSessionModel> getSessionById(String id);

  Future<FocusSessionModel> createSession(FocusSessionModel session);

  Future<FocusSessionModel> updateSession(FocusSessionModel session);

  Future<void> deleteSession(String id);

  Future<FocusSessionModel?> getActiveSession();

  Stream<List<FocusSessionModel>> watchSessions();
}

class FocusRemoteDataSourceImpl implements FocusRemoteDataSource {
  final SupabaseClient _client;

  FocusRemoteDataSourceImpl(this._client);

  @override
  Future<List<FocusSessionModel>> getSessions({
    DateTime? startDate,
    DateTime? endDate,
    String? type,
  }) async {
    var query = _client.from('focus_sessions').select();

    if (startDate != null) {
      query = query.gte('start_time', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('end_time', endDate.toIso8601String());
    }
    if (type != null) {
      query = query.eq('type', type);
    }

    final data = await query.order('start_time', ascending: false);
    return (data as List)
        .map((json) => FocusSessionModel.fromJson(json))
        .toList();
  }

  @override
  Future<FocusSessionModel> getSessionById(String id) async {
    final data = await _client
        .from('focus_sessions')
        .select()
        .eq('id', id)
        .single();
    return FocusSessionModel.fromJson(data);
  }

  @override
  Future<FocusSessionModel> createSession(FocusSessionModel session) async {
    final data = await _client
        .from('focus_sessions')
        .insert(session.toJson())
        .select()
        .single();
    return FocusSessionModel.fromJson(data);
  }

  @override
  Future<FocusSessionModel> updateSession(FocusSessionModel session) async {
    final data = await _client
        .from('focus_sessions')
        .update(session.toJson())
        .eq('id', session.id)
        .select()
        .single();
    return FocusSessionModel.fromJson(data);
  }

  @override
  Future<void> deleteSession(String id) async {
    await _client.from('focus_sessions').delete().eq('id', id);
  }

  @override
  Future<FocusSessionModel?> getActiveSession() async {
    final data = await _client
        .from('focus_sessions')
        .select()
        .isFilter('end_time', null)
        .order('start_time', ascending: false)
        .limit(1)
        .maybeSingle();
    return data != null ? FocusSessionModel.fromJson(data) : null;
  }

  @override
  Stream<List<FocusSessionModel>> watchSessions() {
    return _client
        .from('focus_sessions')
        .stream(primaryKey: ['id'])
        .order('start_time', ascending: false)
        .map((data) => data
            .map((json) => FocusSessionModel.fromJson(json))
            .toList());
  }
}
