import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/repositories/advice_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/failures/failures.dart';

import '../entities/advice_entity.dart';

class AdviceUseCase {
  final adviceRepo = AdviceRepositoryImpl();

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
   return adviceRepo.getAdviceFromDataSource();
    // space for business logic
  }

  // Future<Either<Failure, AdviceEntity>> getAdvice() async {
  //   // call a repository to get data (failure or success)
  //   // proceed with business logic (manipulate data)
  //   await Future.delayed(const Duration(seconds: 3));

  //   // call to repo went good: -> return date, ot a failure
  //   // return right(const AdviceEntity(advice: "fake advice to test", id: 1));

  //   // call to repo went bad or logic had an error -> return failure
  //   return left(CacheFailure());
  // }
}
