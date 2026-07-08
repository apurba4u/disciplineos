import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks({
    String? status,
    String? priority,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<TaskModel> getTaskById(String id);

  Future<TaskModel> createTask(TaskModel task);

  Future<TaskModel> updateTask(TaskModel task);

  Future<void> deleteTask(String id);

  Stream<List<TaskModel>> watchTasks();
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final SupabaseClient _client;

  TaskRemoteDataSourceImpl(this._client);

  @override
  Future<List<TaskModel>> getTasks({
    String? status,
    String? priority,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var query = _client.from('tasks').select();

    if (status != null) {
      query = query.eq('status', status);
    }
    if (priority != null) {
      query = query.eq('priority', priority);
    }
    if (category != null) {
      query = query.eq('category', category);
    }
    if (startDate != null) {
      query = query.gte('deadline', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('deadline', endDate.toIso8601String());
    }

    final data = await query.order('created_at', ascending: false);
    return (data as List)
        .map((json) => TaskModel.fromJson(json))
        .toList();
  }

  @override
  Future<TaskModel> getTaskById(String id) async {
    final data = await _client
        .from('tasks')
        .select()
        .eq('id', id)
        .single();
    return TaskModel.fromJson(data);
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    final data = await _client
        .from('tasks')
        .insert(task.toJson())
        .select()
        .single();
    return TaskModel.fromJson(data);
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    final data = await _client
        .from('tasks')
        .update(task.toJson())
        .eq('id', task.id)
        .select()
        .single();
    return TaskModel.fromJson(data);
  }

  @override
  Future<void> deleteTask(String id) async {
    await _client.from('tasks').delete().eq('id', id);
  }

  @override
  Stream<List<TaskModel>> watchTasks() {
    return _client
        .from('tasks')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data
            .map((json) => TaskModel.fromJson(json))
            .toList());
  }
}
