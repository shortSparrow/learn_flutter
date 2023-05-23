import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/entities/advice_entity.dart';

import '../failures/failures.dart';

abstract class AdviceRepository {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource();
}
