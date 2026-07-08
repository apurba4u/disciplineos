enum FriendStatus {
  pending,
  accepted,
  blocked;

  String get label {
    switch (this) {
      case FriendStatus.pending:
        return 'Pending';
      case FriendStatus.accepted:
        return 'Accepted';
      case FriendStatus.blocked:
        return 'Blocked';
    }
  }
}

class Friend {
  final String id;
  final String userId;
  final String friendId;
  final String friendName;
  final String? friendPhotoUrl;
  final FriendStatus status;
  final DateTime createdAt;

  const Friend({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.friendName,
    this.friendPhotoUrl,
    this.status = FriendStatus.pending,
    required this.createdAt,
  });

  Friend copyWith({
    String? id,
    String? userId,
    String? friendId,
    String? friendName,
    String? friendPhotoUrl,
    FriendStatus? status,
    DateTime? createdAt,
  }) {
    return Friend(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      friendId: friendId ?? this.friendId,
      friendName: friendName ?? this.friendName,
      friendPhotoUrl: friendPhotoUrl ?? this.friendPhotoUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
