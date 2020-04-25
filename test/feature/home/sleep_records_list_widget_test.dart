import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' as intl;
import 'package:meta/meta.dart';
import 'package:sleeptracker/feature/home/sleep_records_list_widget.dart';

void main() {
  group('SleepRecordDateWidget', () {
    setUp(() {
      initializeDateFormatting('en');
    });

    @isTest
    void testWidgetWithDate(
      String description,
      DateTime date,
      String expectedFirstLine,
      String expectedSecondLine,
    ) {
      return testWidgets(description, (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: SleepRecordDateWidget(date),
          ),
        );

        expect(find.text(expectedFirstLine), findsOneWidget);
        expect(find.text(expectedSecondLine), findsOneWidget);
      });
    }

    // 12h clock: https://pl.wikipedia.org/wiki/Zegar_12-godzinny

    testWidgetWithDate('displays 12:00 date as 12:00 PM',
        DateTime(2020, 5, 4, 12, 00), '12:00', 'PM');

    testWidgetWithDate('displays 8:01 date as 8:01 AM',
        DateTime(2020, 5, 4, 8, 01), '8:01', 'AM');

    testWidgetWithDate('displays 00:00 date as 12:00 AM',
        DateTime(2020, 5, 4, 0, 0), '12:00', 'AM');

    testWidgetWithDate('displays 12:01 date as 12:01 PM',
        DateTime(2020, 5, 4, 12, 01), '12:01', 'PM');

    testWidgetWithDate('displays 14:00 as 2:00 PM',
        DateTime(2020, 5, 4, 14, 00), '2:00', 'PM');

    testWidgetWithDate('displays 22:00 as 10:00 PM',
        DateTime(2020, 5, 4, 22, 00), '10:00', 'PM');
  });

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
