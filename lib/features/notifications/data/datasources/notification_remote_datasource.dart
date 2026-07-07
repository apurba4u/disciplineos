import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications({
    bool? unreadOnly,
    String? type,
  });

  Future<NotificationModel> getNotificationById(String id);

  Future<void> markAsRead(String id);

  Future<void> markAllAsRead();

  Future<void> deleteNotification(String id);

  Future<void> clearAll();

  Future<int> getUnreadCount();

  Stream<List<NotificationModel>> watchNotifications();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final SupabaseClient _client;

  NotificationRemoteDataSourceImpl(this._client);

  @override
  Future<List<NotificationModel>> getNotifications({
    bool? unreadOnly,
    String? type,
  }) async {
    var query = _client.from('notifications').select();

    if (unreadOnly == true) {
      query = query.eq('read', false);
    }
    if (type != null) {
      query = query.eq('type', type);
    }

    final data = await query.order('created_at', ascending: false);
    return (data as List)
        .map((json) => NotificationModel.fromJson(json))
        .toList();
  }

  @override
  Future<NotificationModel> getNotificationById(String id) async {
    final data = await _client
        .from('notifications')
        .select()
        .eq('id', id)
        .single();
    return NotificationModel.fromJson(data);
  }

  @override
  Future<void> markAsRead(String id) async {
    await _client.from('notifications').update({'read': true}).eq('id', id);
  }

  @override
  Future<void> markAllAsRead() async {
    await _client
        .from('notifications')
        .update({'read': true})
        .eq('read', false);
  }

  @override
  Future<void> deleteNotification(String id) async {
    await _client.from('notifications').delete().eq('id', id);
  }

  @override
  Future<void> clearAll() async {
    await _client.from('notifications').delete();
  }

  @override
  Future<int> getUnreadCount() async {
    final data = await _client
        .from('notifications')
        .select('id')
        .eq('read', false);
    return (data as List).length;
  }

  @override
  Stream<List<NotificationModel>> watchNotifications() {
    return _client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data
            .map((json) => NotificationModel.fromJson(json))
            .toList());
  }
}
