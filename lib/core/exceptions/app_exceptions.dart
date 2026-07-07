class AppException implements Exception {
  final String message;
  final String? code;
  const AppException({required this.message, this.code});

  @override
  String toString() => 'AppException: $message (code: $code)';
}

final class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection',
    super.code = 'NETWORK_ERROR',
  });
}

final class AuthException extends AppException {
  const AuthException({
    super.message = 'Authentication failed',
    super.code = 'AUTH_ERROR',
  });
}

final class ValidationException extends AppException {
  const ValidationException({
    super.message = 'Validation failed',
    super.code = 'VALIDATION_ERROR',
  });
}

final class AIException extends AppException {
  const AIException({
    super.message = 'AI provider error',
    super.code = 'AI_ERROR',
  });
}

final class StorageException extends AppException {
  const StorageException({
    super.message = 'Storage error',
    super.code = 'STORAGE_ERROR',
  });
}

final class ServerException extends AppException {
  const ServerException({
    super.message = 'Server error',
    super.code = 'SERVER_ERROR',
  });
}
