import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:sleeptracker/feature/home/home_widget.dart';
import 'package:sleeptracker/utils/date_utils.dart';

class _MockDateUtils extends Mock implements DateUtils {}

void main() {
  group('CurrentDateHeader', () {
    testWidgets('displays formatted currentDate', (tester) async {
      initializeDateFormatting('en');

      final dateUtils = _MockDateUtils();
      when(dateUtils.now()).thenReturn(DateTime(2020, 4, 24, 17));

      final widget = Provider<DateUtils>.value(
        value: dateUtils,
        child: const Directionality(
            textDirection: TextDirection.ltr, child: CurrentDateHeader()),
      );
      await tester.pumpWidget(widget);

      final formattedDateFinder = find.text('FRIDAY, 24 APR 2020');
      expect(formattedDateFinder, findsOneWidget);
    });
  });
}
