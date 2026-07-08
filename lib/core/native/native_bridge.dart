import 'package:flutter/services.dart';
import '../logger/app_logger.dart';

class NativeBridge {
  static const MethodChannel _channel = MethodChannel('discipline_os/native');

  static Future<Map<String, dynamic>> getUsageStats() async {
    try {
      final result = await _channel.invokeMethod('getUsageStats');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      AppLogger.error('Failed to get usage stats', e);
      return {'success': false, 'data': {}, 'message': e.message};
    }
  }

  static Future<Map<String, dynamic>> startFocusLock(List<String> blockedApps) async {
    try {
      final result = await _channel.invokeMethod('startFocusLock', {
        'blockedApps': blockedApps,
      });
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      AppLogger.error('Failed to start focus lock', e);
      return {'success': false, 'data': {}, 'message': e.message};
    }
  }

  static Future<Map<String, dynamic>> stopFocusLock() async {
    try {
      final result = await _channel.invokeMethod('stopFocusLock');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      AppLogger.error('Failed to stop focus lock', e);
      return {'success': false, 'data': {}, 'message': e.message};
    }
  }

  static Future<Map<String, dynamic>> getSteps() async {
    try {
      final result = await _channel.invokeMethod('getSteps');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      AppLogger.error('Failed to get steps', e);
      return {'success': false, 'data': {}, 'message': e.message};
    }
  }

  static Future<Map<String, dynamic>> requestPermissions(List<String> permissions) async {
    try {
      final result = await _channel.invokeMethod('requestPermissions', {
        'permissions': permissions,
      });
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      AppLogger.error('Failed to request permissions', e);
      return {'success': false, 'data': {}, 'message': e.message};
    }
  }

  static Future<Map<String, dynamic>> scheduleAlarm({
    required int id,
    required int timestamp,
    required String title,
    required String body,
  }) async {
    try {
      final result = await _channel.invokeMethod('scheduleAlarm', {
        'id': id,
        'timestamp': timestamp,
        'title': title,
        'body': body,
      });
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      AppLogger.error('Failed to schedule alarm', e);
      return {'success': false, 'data': {}, 'message': e.message};
    }
  }

  static Future<Map<String, dynamic>> cancelAlarm(int id) async {
    try {
      final result = await _channel.invokeMethod('cancelAlarm', {'id': id});
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      AppLogger.error('Failed to cancel alarm', e);
      return {'success': false, 'data': {}, 'message': e.message};
    }
  }
}
