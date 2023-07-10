import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/application/pages/advice/advice_page.dart';
import 'package:flutter_clean_architecture/application/pages/advice/cubit/advice_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAdviceCubit extends MockCubit<AdviceCubitState>
    implements AdviceCubit {}

void main() {
  Widget widgetUnderTest({required AdviceCubit cubit}) {
    return BlocProvider<AdviceCubit>(
      create: (context) => cubit,
      child: const MaterialApp(
        home: AdvicePage(),
      ),
    );
  }

  group('Advice Page', () {
    late AdviceCubit mockAdviceCubit;

    setUp(() => {mockAdviceCubit = MockAdviceCubit()});

    group('Should be displayed in ViewState', () {
      testWidgets(
        'Initial when cubits Emits AdviceInitial()',
        (widgetTester) async {
          whenListen(
            mockAdviceCubit,
            Stream.fromIterable([AdviceInitial()]),
            initialState: AdviceInitial(),
          );

          await widgetTester
              .pumpWidget(widgetUnderTest(cubit: mockAdviceCubit));
        },
      );
    });
  });
}
