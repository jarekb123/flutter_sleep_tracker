import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart' as intl;
import 'package:meta/meta.dart';
import 'package:sleeptracker/shared_widgets/duration_text.dart';

void main() {
  group('DurationText', () {
    setUpAll(() => intl.Intl.defaultLocale = 'en');

    @isTest
    void testDurationText(Duration duration, String expectedText) {
      testWidgets(
        '$duration is represented as "$expectedText"',
        (tester) async {
          final widget = Directionality(
            textDirection: TextDirection.ltr,
            child: DurationText(duration),
          );
          await tester.pumpWidget(widget);

          expect(find.text(expectedText), findsOneWidget);
        },
      );
    }

    testDurationText(const Duration(), '0 hours 0 minutes');
    testDurationText(const Duration(hours: 1), '1 hour 0 minutes');
    testDurationText(const Duration(hours: 1, minutes: 1), '1 hour 1 minute');

    testDurationText(const Duration(hours: 12, minutes: 5, seconds: 10),
        '12 hours 5 minutes');
  });
}