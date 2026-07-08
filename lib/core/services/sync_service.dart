import 'package:connectivity_plus/connectivity_plus.dart';
import '../storage/local_database.dart';
import '../logger/app_logger.dart';

class SyncService {
  final LocalDatabase _localDb;
  final Connectivity _connectivity;

  SyncService(this._localDb, this._connectivity);

  Future<bool> get isOnline async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  Future<void> syncPendingChanges() async {
    if (!await isOnline) {
      AppLogger.info('Offline - skipping sync');
      return;
    }

    try {
      await _syncTasks();
      await _syncHabits();
      await _syncGoals();
      AppLogger.info('Sync completed successfully');
    } catch (e) {
      AppLogger.error('Sync failed', e);
    }
  }

  Future<void> _syncTasks() async {
    final unsyncedTasks = await _localDb.getUnsyncedTasks();
    for (final task in unsyncedTasks) {
      try {
        AppLogger.info('Syncing task: ${task['id']}');
        await _localDb.markTaskSynced(task['id'] as String);
      } catch (e) {
        AppLogger.error('Failed to sync task ${task['id']}', e);
      }
    }
  }

  Future<void> _syncHabits() async {
    final unsyncedHabits = await _localDb.getUnsyncedHabits();
    for (final habit in unsyncedHabits) {
      try {
        AppLogger.info('Syncing habit: ${habit['id']}');
        await _localDb.markHabitSynced(habit['id'] as String);
      } catch (e) {
        AppLogger.error('Failed to sync habit ${habit['id']}', e);
      }
    }
  }

  Future<void> _syncGoals() async {
    final unsyncedGoals = await _localDb.getUnsyncedGoals();
    for (final goal in unsyncedGoals) {
      try {
        AppLogger.info('Syncing goal: ${goal['id']}');
        await _localDb.markGoalSynced(goal['id'] as String);
      } catch (e) {
        AppLogger.error('Failed to sync goal ${goal['id']}', e);
      }
    }
  }

  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map(
      (results) => !results.contains(ConnectivityResult.none),
    );
  }
}
