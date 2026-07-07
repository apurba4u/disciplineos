import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/achievement.dart';

abstract class GamificationRepository {
  Future<Either<Failure, UserProgress>> getUserProgress(String userId);

  Future<Either<Failure, UserProgress>> addXp(String userId, int xp);

  Future<Either<Failure, List<Achievement>>> getAchievements();

  Future<Either<Failure, Achievement>> unlockAchievement(
    String userId,
    String achievementId,
  );

  Stream<UserProgress> watchUserProgress(String userId);
}
