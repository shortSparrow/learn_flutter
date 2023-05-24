import 'package:flutter_clean_architecture/application/pages/advice/cubit/advice_cubit.dart';
import 'package:flutter_clean_architecture/data/datasource/advice_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/repositories/advice_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/repositories/advice_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/advice_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I; // sl == Service Locator

Future<void> init() async {
  // ! application layer
  // Factory = every time a new/fresh instance of a class
  sl.registerFactory(() => AdviceCubit(
      adviceUseCase:
          sl())); // sl() - check if adviceUseCase exist in sl and if exist add it as parameter

  // ! domain layer
  sl.registerFactory(() => AdviceUseCase(adviceRepo: sl()));

  // ! data layer
  sl.registerFactory<AdviceRepository>(() => AdviceRepositoryImpl(adviceRemoteDataSource: sl()));
  sl.registerFactory<AdviceRemoteDataSource>(() => AdviceRemoteDataSourceImpl(client: sl()));

  // ! externs
  sl.registerFactory(() => http.Client());
}
