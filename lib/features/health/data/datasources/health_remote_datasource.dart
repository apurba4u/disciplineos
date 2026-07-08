import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/step_log_model.dart';
import '../models/water_log_model.dart';
import '../models/sleep_log_model.dart';

abstract class HealthRemoteDataSource {
  Future<StepLogModel?> getTodaySteps();
  Future<StepLogModel> logSteps(StepLogModel log);
  Future<SleepLogModel?> getTodaySleep();
  Future<SleepLogModel> logSleep(SleepLogModel log);
  Future<int> getTodayWaterIntake();
  Future<List<WaterLogModel>> getTodayWaterLogs();
  Future<WaterLogModel> logWater(WaterLogModel log);
}

class HealthRemoteDataSourceImpl implements HealthRemoteDataSource {
  final SupabaseClient _client;

  HealthRemoteDataSourceImpl(this._client);

  @override
  Future<StepLogModel?> getTodaySteps() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final data = await _client
        .from('step_logs')
        .select()
        .eq('date', today)
        .maybeSingle();
    return data != null ? StepLogModel.fromJson(data) : null;
  }

  @override
  Future<StepLogModel> logSteps(StepLogModel log) async {
    final data = await _client
        .from('step_logs')
        .upsert(log.toJson())
        .select()
        .single();
    return StepLogModel.fromJson(data);
  }

  @override
  Future<SleepLogModel?> getTodaySleep() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final data = await _client
        .from('sleep_logs')
        .select()
        .eq('date', today)
        .maybeSingle();
    return data != null ? SleepLogModel.fromJson(data) : null;
  }

  @override
  Future<SleepLogModel> logSleep(SleepLogModel log) async {
    final data = await _client
        .from('sleep_logs')
        .insert(log.toJson())
        .select()
        .single();
    return SleepLogModel.fromJson(data);
  }

  @override
  Future<int> getTodayWaterIntake() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final data = await _client
        .from('water_logs')
        .select('amount_ml')
        .gte('logged_at', today);
    return (data as List).fold<int>(
      0,
      (sum, log) => sum + (log['amount_ml'] as int),
    );
  }

  @override
  Future<List<WaterLogModel>> getTodayWaterLogs() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final data = await _client
        .from('water_logs')
        .select()
        .gte('logged_at', today)
        .order('logged_at', ascending: false);
    return (data as List)
        .map((json) => WaterLogModel.fromJson(json))
        .toList();
  }

  @override
  Future<WaterLogModel> logWater(WaterLogModel log) async {
    final data = await _client
        .from('water_logs')
        .insert(log.toJson())
        .select()
        .single();
    return WaterLogModel.fromJson(data);
  }
}
