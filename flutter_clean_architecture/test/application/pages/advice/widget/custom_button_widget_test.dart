import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/application/pages/advice/widgets/custom_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class OnCustomButtonTap {
  void call();
}

class MockOnCUstomButtonTap extends Mock implements OnCustomButtonTap {}

void main() {
  Widget widgetUnderTest({Function? callback}) {
    return MaterialApp(
      home: Scaffold(
        body: CustomButton(onTap: callback),
      ),
    );
  }

  group('CustomButton', () {
    group('is Button rendered correctly', () {
      testWidgets(
        'has all part that he needs',
        (widgetTester) async {
          await widgetTester.pumpWidget(widgetUnderTest());

          final buttonLabelFinder = find.text('Get Advice');

          expect(buttonLabelFinder, findsOneWidget);
        },
      );
    });

    group('should handle on tap', () {
      testWidgets('when button pressed', (widgetTester) async {
        final mockCustomTap = MockOnCUstomButtonTap();
        await widgetTester.pumpWidget(widgetUnderTest(callback: mockCustomTap));

        final customButtonFinder = find.byType(CustomButton);
        await widgetTester.tap(customButtonFinder);
        verify(mockCustomTap()).called(1);
      });
    });
  });
}
