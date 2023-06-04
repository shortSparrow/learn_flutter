import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/datasource/advice_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/exceptions/exceptions.dart';
import 'package:flutter_clean_architecture/data/models/advice_model.dart';
import 'package:flutter_clean_architecture/data/repositories/advice_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_clean_architecture/domain/failures/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDataSourceImpl>()])
void main() {
  group('AdviceRepositoryImpl', () {
    group('Should return AdviceEntity', () {
      test('When AdviceRemoteDataSource returns AdviceModel', () async {
        final mockAdviceRemoteDataResource = MockAdviceRemoteDataSourceImpl();
        final adviceRepoImplUnderTest = AdviceRepositoryImpl(
            adviceRemoteDataSource: mockAdviceRemoteDataResource);

        when(mockAdviceRemoteDataResource.getRandomAdviceFromApi()).thenAnswer(
            (realInvocation) =>
                Future.value(AdviceModel(advice: "advice test", id: 1)));

        final result = await adviceRepoImplUnderTest.getAdviceFromDataSource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
          result,
          Right<Failure, AdviceModel>(
            AdviceModel(advice: "advice test", id: 1),
          ),
        );

        verify(mockAdviceRemoteDataResource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockAdviceRemoteDataResource);
      });
    });

    group('Should return left with', () {
      test('a ServerFailure when a ServerException occurs', () async {
        final mockAdviceRemoteDataResource = MockAdviceRemoteDataSourceImpl();
        final adviceRepoImplUnderTest = AdviceRepositoryImpl(
            adviceRemoteDataSource: mockAdviceRemoteDataResource);

        when(mockAdviceRemoteDataResource.getRandomAdviceFromApi())
            .thenThrow(ServerException());

        final result = await adviceRepoImplUnderTest.getAdviceFromDataSource();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
      });

      test('a GeneralFailure on all other Exceptions', () async {
        final mockAdviceRemoteDataResource = MockAdviceRemoteDataSourceImpl();
        final adviceRepoImplUnderTest = AdviceRepositoryImpl(
            adviceRemoteDataSource: mockAdviceRemoteDataResource);

        when(mockAdviceRemoteDataResource.getRandomAdviceFromApi())
            .thenThrow(const SocketException("test"));

        final result = await adviceRepoImplUnderTest.getAdviceFromDataSource();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
      });
    });
  });
}
