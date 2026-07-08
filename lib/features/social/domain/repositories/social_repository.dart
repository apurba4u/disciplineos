import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/friend.dart';

abstract class SocialRepository {
  Future<Either<Failure, List<Friend>>> getFriends();
  Future<Either<Failure, List<Friend>>> getPendingRequests();
  Future<Either<Failure, Friend>> sendFriendRequest(String friendId);
  Future<Either<Failure, void>> acceptFriendRequest(String friendId);
  Future<Either<Failure, void>> rejectFriendRequest(String friendId);
  Future<Either<Failure, void>> removeFriend(String friendId);
}
