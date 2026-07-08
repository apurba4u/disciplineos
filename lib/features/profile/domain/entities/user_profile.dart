class UserProfile {
  final String id;
  final String userId;
  final String name;
  final String? email;
  final String? photoUrl;
  final String? gender;
  final DateTime? dateOfBirth;
  final double? height;
  final double? weight;
  final String? occupation;
  final String? timezone;
  final String? language;
  final String? country;
  final List<String> goals;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.userId,
    required this.name,
    this.email,
    this.photoUrl,
    this.gender,
    this.dateOfBirth,
    this.height,
    this.weight,
    this.occupation,
    this.timezone,
    this.language,
    this.country,
    this.goals = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  UserProfile copyWith({
    String? id,
    String? userId,
    String? name,
    String? email,
    String? photoUrl,
    String? gender,
    DateTime? dateOfBirth,
    double? height,
    double? weight,
    String? occupation,
    String? timezone,
    String? language,
    String? country,
    List<String>? goals,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      occupation: occupation ?? this.occupation,
      timezone: timezone ?? this.timezone,
      language: language ?? this.language,
      country: country ?? this.country,
      goals: goals ?? this.goals,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  double? get bmi {
    if (height == null || weight == null || height! <= 0) return null;
    final heightMeters = height! / 100;
    return weight! / (heightMeters * heightMeters);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}
