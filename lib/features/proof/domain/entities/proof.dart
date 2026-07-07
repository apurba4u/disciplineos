enum VerificationStatus {
  verified,
  likelyVerified,
  uncertain,
  rejected,
  manualReview;

  String get label {
    switch (this) {
      case VerificationStatus.verified:
        return 'Verified';
      case VerificationStatus.likelyVerified:
        return 'Likely Verified';
      case VerificationStatus.uncertain:
        return 'Uncertain';
      case VerificationStatus.rejected:
        return 'Rejected';
      case VerificationStatus.manualReview:
        return 'Manual Review';
    }
  }
}

class Proof {
  final String id;
  final String taskId;
  final String userId;
  final String storagePath;
  final String imageUrl;
  final String aiProvider;
  final int confidenceScore;
  final VerificationStatus verificationStatus;
  final String? reasoning;
  final String? suggestions;
  final DateTime createdAt;

  const Proof({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.storagePath,
    required this.imageUrl,
    required this.aiProvider,
    required this.confidenceScore,
    required this.verificationStatus,
    this.reasoning,
    this.suggestions,
    required this.createdAt,
  });

  Proof copyWith({
    String? id,
    String? taskId,
    String? userId,
    String? storagePath,
    String? imageUrl,
    String? aiProvider,
    int? confidenceScore,
    VerificationStatus? verificationStatus,
    String? reasoning,
    String? suggestions,
    DateTime? createdAt,
  }) {
    return Proof(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      storagePath: storagePath ?? this.storagePath,
      imageUrl: imageUrl ?? this.imageUrl,
      aiProvider: aiProvider ?? this.aiProvider,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      reasoning: reasoning ?? this.reasoning,
      suggestions: suggestions ?? this.suggestions,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isVerified =>
      verificationStatus == VerificationStatus.verified ||
      verificationStatus == VerificationStatus.likelyVerified;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Proof && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
