import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/goal_model.dart';

abstract class GoalRemoteDataSource {
  Future<List<GoalModel>> getGoals({
    String? category,
    String? status,
  });

  Future<GoalModel> getGoalById(String id);

  Future<GoalModel> createGoal(GoalModel goal);

  Future<GoalModel> updateGoal(GoalModel goal);

  Future<void> deleteGoal(String id);

  Stream<List<GoalModel>> watchGoals();
}

class GoalRemoteDataSourceImpl implements GoalRemoteDataSource {
  final SupabaseClient _client;

  GoalRemoteDataSourceImpl(this._client);

  @override
  Future<List<GoalModel>> getGoals({
    String? category,
    String? status,
  }) async {
    var query = _client.from('goals').select();

    if (category != null) {
      query = query.eq('category', category);
    }
    if (status != null) {
      query = query.eq('status', status);
    }

    final data = await query.order('created_at', ascending: false);
    return (data as List)
        .map((json) => GoalModel.fromJson(json))
        .toList();
  }

  @override
  Future<GoalModel> getGoalById(String id) async {
    final data = await _client
        .from('goals')
        .select()
        .eq('id', id)
        .single();
    return GoalModel.fromJson(data);
  }

  @override
  Future<GoalModel> createGoal(GoalModel goal) async {
    final data = await _client
        .from('goals')
        .insert(goal.toJson())
        .select()
        .single();
    return GoalModel.fromJson(data);
  }

  @override
  Future<GoalModel> updateGoal(GoalModel goal) async {
    final data = await _client
        .from('goals')
        .update(goal.toJson())
        .eq('id', goal.id)
        .select()
        .single();
    return GoalModel.fromJson(data);
  }

  @override
  Future<void> deleteGoal(String id) async {
    await _client.from('goals').delete().eq('id', id);
  }

  @override
  Stream<List<GoalModel>> watchGoals() {
    return _client
        .from('goals')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data
            .map((json) => GoalModel.fromJson(json))
            .toList());
  }
}
