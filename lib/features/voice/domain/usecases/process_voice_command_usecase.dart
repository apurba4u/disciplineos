import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/voice_command.dart';
import '../repositories/voice_repository.dart';

class ProcessVoiceCommandUseCase {
  final VoiceRepository _repository;

  ProcessVoiceCommandUseCase(this._repository);

  Future<Either<Failure, VoiceCommand>> call(String text) {
    return _repository.processCommand(text);
  }
}
