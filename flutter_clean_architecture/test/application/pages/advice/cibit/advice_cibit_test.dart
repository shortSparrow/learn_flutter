import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/application/pages/advice/cubit/advice_cubit.dart';
import 'package:flutter_clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_clean_architecture/domain/failures/failures.dart';
import 'package:flutter_clean_architecture/domain/usecases/advice_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceUseCase extends Mock implements AdviceUseCase {}

void main() {
  group('Advice Cubit', () {
    group('Should emit', () {
      MockAdviceUseCase mockAdviceUseCase = MockAdviceUseCase();

      blocTest(
        'Nothing when no method is called',
        build: () => AdviceCubit(adviceUseCase: mockAdviceUseCase),
        expect: () => const <AdviceCubitState>[],
      );
      blocTest(
        '[AdviceStateLoading,AdviceStateLoaded] when adviceRequested() is called',
        setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
          (invocation) => Future.value(
            const Right<Failure, AdviceEntity>(
              AdviceEntity(advice: 'advice', id: 1),
            ),
          ),
        ),
        build: () => AdviceCubit(adviceUseCase: mockAdviceUseCase),
        act: (cubit) => cubit.adviceRequest(),
        expect: () => <AdviceCubitState>[
          AdviceStateLoading(),
          const AdviceStateLoaded(advice: 'advice')
        ],
      );

      group(
        '[AdviceStateLoading, AdviceStateError] when adviceRequested() is called',
        () {
          MockAdviceUseCase mockAdviceUseCase = MockAdviceUseCase();
          blocTest(
            'and a ServerFailure occors',
            setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  ServerFailure(),
                ),
              ),
            ),
            build: () => AdviceCubit(adviceUseCase: mockAdviceUseCase),
            act: (cubit) => cubit.adviceRequest(),
            expect: () => <AdviceCubitState>[
              AdviceStateLoading(),
              const AdviceStateError(errorMessage: serverFailureMessage),
            ],
          );

          blocTest(
            'and a CacheFailure occors',
            setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  CacheFailure(),
                ),
              ),
            ),
            build: () => AdviceCubit(adviceUseCase: mockAdviceUseCase),
            act: (cubit) => cubit.adviceRequest(),
            expect: () => <AdviceCubitState>[
              AdviceStateLoading(),
              const AdviceStateError(errorMessage: cacheFailureMessage),
            ],
          );

          blocTest(
            'and a GeneralFailure occors',
            setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  GeneralFailure(),
                ),
              ),
            ),
            build: () => AdviceCubit(adviceUseCase: mockAdviceUseCase),
            act: (cubit) => cubit.adviceRequest(),
            expect: () => <AdviceCubitState>[
              AdviceStateLoading(),
              const AdviceStateError(errorMessage: generalFailureMessage),
            ],
          );
        },
      );
    });
  });
}
