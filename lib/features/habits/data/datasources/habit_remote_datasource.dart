import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/habit_model.dart';

abstract class HabitRemoteDataSource {
  Future<List<HabitModel>> getHabits({
    bool? activeOnly,
    String? category,
  });

  Future<HabitModel> getHabitById(String id);

  Future<HabitModel> createHabit(HabitModel habit);

  Future<HabitModel> updateHabit(HabitModel habit);

  Future<void> deleteHabit(String id);

  Stream<List<HabitModel>> watchHabits();
}

class HabitRemoteDataSourceImpl implements HabitRemoteDataSource {
  final SupabaseClient _client;

  HabitRemoteDataSourceImpl(this._client);

  @override
  Future<List<HabitModel>> getHabits({
    bool? activeOnly,
    String? category,
  }) async {
    var query = _client.from('habits').select();

    if (activeOnly == true) {
      query = query.eq('is_active', true);
    }
    if (category != null) {
      query = query.eq('category', category);
    }

    final data = await query.order('created_at', ascending: false);
    return (data as List)
        .map((json) => HabitModel.fromJson(json))
        .toList();
  }

  @override
  Future<HabitModel> getHabitById(String id) async {
    final data = await _client
        .from('habits')
        .select()
        .eq('id', id)
        .single();
    return HabitModel.fromJson(data);
  }

  @override
  Future<HabitModel> createHabit(HabitModel habit) async {
    final data = await _client
        .from('habits')
        .insert(habit.toJson())
        .select()
        .single();
    return HabitModel.fromJson(data);
  }

  @override
  Future<HabitModel> updateHabit(HabitModel habit) async {
    final data = await _client
        .from('habits')
        .update(habit.toJson())
        .eq('id', habit.id)
        .select()
        .single();
    return HabitModel.fromJson(data);
  }

  @override
  Future<void> deleteHabit(String id) async {
    await _client.from('habits').delete().eq('id', id);
  }

  @override
  Stream<List<HabitModel>> watchHabits() {
    return _client
        .from('habits')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data
            .map((json) => HabitModel.fromJson(json))
            .toList());
  }
}
