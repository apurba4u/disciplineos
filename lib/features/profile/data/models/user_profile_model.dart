import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.userId,
    required super.name,
    super.email,
    super.photoUrl,
    super.gender,
    super.dateOfBirth,
    super.height,
    super.weight,
    super.occupation,
    super.timezone,
    super.language,
    super.country,
    super.goals,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      photoUrl: json['photo_url'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      occupation: json['occupation'] as String?,
      timezone: json['timezone'] as String?,
      language: json['language'] as String?,
      country: json['country'] as String?,
      goals: (json['goals'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'email': email,
      'photo_url': photoUrl,
      'gender': gender,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'height': height,
      'weight': weight,
      'occupation': occupation,
      'timezone': timezone,
      'language': language,
      'country': country,
      'goals': goals,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
