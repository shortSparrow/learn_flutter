import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/application/pages/advice/widgets/advice_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({required String adviceText}) {
    return MaterialApp(
      home: AdviceField(advice: adviceText),
    );
  }

  group('AdviceField', () {
    group('Should be displayed correctly', () {
      testWidgets('When a short text given', (widgetTester) async {
        const text = 'a';

        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();

        final adviceFiledFinder = find.textContaining('a');
        expect(adviceFiledFinder, findsOneWidget);
      });

      testWidgets('When a long text given', (widgetTester) async {
        const text =
            'fkrgn oignekj ngsek gnelk gnek gnew kgnwkj gnwkgnw ge;lsgm lgm wkg kw gnwk. gkel gnawlk gnwa f gw mgawkl gn gwak gmwlagmwlgm s wakgnwalkgna lwkgnwakgwn agagwnagwak ngwlkanglwak g fwaklfgn wa';

        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();

        final adviceFiledFinder = find.byType(AdviceField);
        expect(adviceFiledFinder, findsOneWidget);
      });

      testWidgets('When no text given', (widgetTester) async {
        const text = '';

        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();

        final adviceFiledFinder = find.byType(AdviceField);
        final adviceText = widgetTester.widget<AdviceField>(find.byType(AdviceField)).advice;

        expect(adviceFiledFinder, findsOneWidget);
        expect(adviceText, '');
      });
    });
  });
}
