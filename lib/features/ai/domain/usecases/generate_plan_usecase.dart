import 'package:dartz/dartz.dart' show Either;
import '../../../../core/ai/ai_response.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/ai_repository.dart';

class GeneratePlanUseCase {
  final AIRepository _repository;

  GeneratePlanUseCase(this._repository);

  Future<Either<Failure, AIResponse>> call({
    required String type,
    required Map<String, dynamic> context,
  }) {
    return _repository.generatePlan(type: type, context: context);
  }
}
