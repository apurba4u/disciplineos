import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/voice_command.dart';

abstract class VoiceRepository {
  Future<Either<Failure, VoiceRecognitionResult>> startListening();
  Future<Either<Failure, void>> stopListening();
  Future<Either<Failure, VoiceCommand>> processCommand(String text);
  Future<Either<Failure, void>> speak(String text);
  Stream<VoiceRecognitionResult> get onRecognitionResult;
  bool get isListening;
}
