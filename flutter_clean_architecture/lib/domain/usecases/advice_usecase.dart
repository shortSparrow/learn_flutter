import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/failures/failures.dart';
import 'package:flutter_clean_architecture/domain/repositories/advice_repository.dart';

import '../entities/advice_entity.dart';

class AdviceUseCase {
  AdviceUseCase({required this.adviceRepo});

  final AdviceRepository adviceRepo;

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDataSource();
    // space for business logic
  }
}
