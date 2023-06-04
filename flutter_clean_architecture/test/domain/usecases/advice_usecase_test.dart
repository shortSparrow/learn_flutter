import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/repositories/advice_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_clean_architecture/domain/failures/failures.dart';
import 'package:flutter_clean_architecture/domain/usecases/advice_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepositoryImpl>()])
void main() {
  group('AdviceUseCase', () {
    group('Should return AdviceEntity', () {
      test('when AdviceRepositoryImpl returns a AdviceModel', () async {
        final mockAdviceRepositoryImpl = MockAdviceRepositoryImpl();
        final adviceUseCaseUnderTest =
            AdviceUseCase(adviceRepo: mockAdviceRepositoryImpl);

        when(mockAdviceRepositoryImpl.getAdviceFromDataSource()).thenAnswer(
            (realInvocation) => Future.value(
                const Right(AdviceEntity(advice: "advice", id: 1))));

        final result = await adviceUseCaseUnderTest.getAdvice();
        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
            result,
            const Right<Failure, AdviceEntity>(
                AdviceEntity(advice: "advice", id: 1)));
        verify(mockAdviceRepositoryImpl.getAdviceFromDataSource()).called(1);
        // when you want to check if method was not called use verifyNever() instead of .called(0)

        verifyNoMoreInteractions(mockAdviceRepositoryImpl);
      });
    });

    group('Should return left with', () {
      test('a ServerFailure', () async {
        final mockAdviceRepositoryImpl = MockAdviceRepositoryImpl();
        final adviceUseCaseUnderTest =
            AdviceUseCase(adviceRepo: mockAdviceRepositoryImpl);

        when(mockAdviceRepositoryImpl.getAdviceFromDataSource()).thenAnswer(
            (realInvocation) => Future.value(Left(ServerFailure())));

        final result = await adviceUseCaseUnderTest.getAdvice();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
        verify(mockAdviceRepositoryImpl.getAdviceFromDataSource()).called(1);
        verifyNoMoreInteractions(mockAdviceRepositoryImpl);
      });

            test('a GeneralFailure', () async {
        final mockAdviceRepositoryImpl = MockAdviceRepositoryImpl();
        final adviceUseCaseUnderTest =
            AdviceUseCase(adviceRepo: mockAdviceRepositoryImpl);

        when(mockAdviceRepositoryImpl.getAdviceFromDataSource()).thenAnswer(
            (realInvocation) => Future.value(Left(GeneralFailure())));

        final result = await adviceUseCaseUnderTest.getAdvice();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
        verify(mockAdviceRepositoryImpl.getAdviceFromDataSource()).called(1);
        verifyNoMoreInteractions(mockAdviceRepositoryImpl);
      });
    });
  });
}
