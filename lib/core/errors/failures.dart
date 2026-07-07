sealed class Failure {
  final String message;
  const Failure({required this.message});
}

final class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error occurred'});
}

final class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'});
}

final class AuthFailure extends Failure {
  const AuthFailure({super.message = 'Authentication failed'});
}

final class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error occurred'});
}

final class ValidationFailure extends Failure {
  const ValidationFailure({super.message = 'Validation failed'});
}

final class AIProviderFailure extends Failure {
  const AIProviderFailure({super.message = 'AI provider error'});
}

final class StorageFailure extends Failure {
  const StorageFailure({super.message = 'Storage error occurred'});
}
