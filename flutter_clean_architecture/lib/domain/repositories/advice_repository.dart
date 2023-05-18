import 'package:flutter_clean_architecture/domain/entities/advice_entity.dart';

abstract class AdviceRepository {
  Future<AdviceEntity> getAdviceFromDataSource();
}
