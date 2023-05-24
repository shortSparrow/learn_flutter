import 'package:flutter_clean_architecture/data/datasource/advice_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/exceptions/exceptions.dart';
import 'package:flutter_clean_architecture/domain/failures/failures.dart';
import 'package:flutter_clean_architecture/domain/entities/advice_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/repositories/advice_repository.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  final AdviceRemoteDataSource adviceRemoteDataSource =
      AdviceRemoteDataSourceImpl();

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      final result = await adviceRemoteDataSource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } on CacheException catch (_) {
      return left(CacheFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
