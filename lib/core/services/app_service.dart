import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env_config.dart';

class AppService {
  static final AppService _instance = AppService._internal();
  factory AppService() => _instance;
  AppService._internal();

  SupabaseClient? _supabaseClient;

  SupabaseClient get supabase {
    if (_supabaseClient == null) {
      throw Exception(
        'Supabase not initialized. Call AppService.initialize() first.',
      );
    }
    return _supabaseClient!;
  }

  bool _initialized = false;
  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (_initialized) return;

    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      publishableKey: EnvConfig.supabaseAnonKey,
    );

    _supabaseClient = Supabase.instance.client;
    _initialized = true;
  }

  void dispose() {
    _supabaseClient?.dispose();
    _supabaseClient = null;
    _initialized = false;
  }
}
