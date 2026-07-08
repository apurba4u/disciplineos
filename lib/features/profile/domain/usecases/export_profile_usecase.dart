import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart' show Either, Right, Left;
import 'package:path_provider/path_provider.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class ExportProfileUseCase {
  final ProfileRepository _repository;

  ExportProfileUseCase(this._repository);

  Future<Either<Failure, String>> call(String userId) async {
    try {
      final profileResult = await _repository.getProfile(userId);
      
      return profileResult.fold(
        (failure) => Left(failure),
        (profile) async {
          final jsonData = _profileToJson(profile);
          final directory = await getApplicationDocumentsDirectory();
          final file = File('${directory.path}/profile_export.json');
          await file.writeAsString(jsonEncode(jsonData));
          return Right(file.path);
        },
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Map<String, dynamic> _profileToJson(UserProfile profile) {
    return {
      'export_date': DateTime.now().toIso8601String(),
      'profile': {
        'name': profile.name,
        'email': profile.email,
        'gender': profile.gender,
        'date_of_birth': profile.dateOfBirth?.toIso8601String(),
        'height': profile.height,
        'weight': profile.weight,
        'occupation': profile.occupation,
        'timezone': profile.timezone,
        'language': profile.language,
        'country': profile.country,
        'goals': profile.goals,
      },
    };
  }
}
