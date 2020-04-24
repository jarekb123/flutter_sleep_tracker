import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sleeptracker/feature/home/records_list_notifiers.dart';
import 'package:sleeptracker/repositories/sleep_records_repo.dart';
import 'package:sleeptracker/theme.dart';
import 'package:sleeptracker/utils/date_utils.dart';

class SleepRecordsList extends StatelessWidget {
  const SleepRecordsList({
    Key key,
  }) : super(key: key);

  static const _borderRadius = BorderRadius.vertical(top: Radius.circular(16));

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: _borderRadius,
      elevation: 4,
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: Consumer<RecordsListNotifier>(
          builder: (context, state, _) {
            // if (state.isLoading) {
            //   return SingleChildScrollView(
            //     child: Column(
            //       mainAxisSize: MainAxisSize.max,
            //       children: <Widget>[
            //         const SizedBox(height: 64),
            //         const CircularProgressIndicator(),
            //         const SizedBox(height: 32),
            //         Text('Loading...')
            //       ],
            //     ),
            //   );
            // }

            return ListView.separated(
              itemCount: 3,
              itemBuilder: (context, index) {
                return SleepRecordWidget(
                  SleepRecord(
                    id: 1,
                    createdAt: DateTime(2020, 4, 24, 22, 30),
                    duration: Duration(hours: 6),
                    sleepType: SleepType.nap,
                  ),
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 1),
            );
          },
        ),
      ),
    );
  }
}

class SleepRecordWidget extends StatelessWidget {
  const SleepRecordWidget(
    this.sleepRecord, {
    Key key,
  }) : super(key: key);

  final SleepRecord sleepRecord;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SleepRecordDateWidget(sleepRecord.createdAt),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Night Sleep',
              style: context.textTheme.bodyText1.colored(context.primaryColor),
            ),
            Text('6 hours 12 minutes'),
          ],
        )
      ],
    );
  }
}

class SleepRecordDateWidget extends StatelessWidget {
  const SleepRecordDateWidget(this.date, {Key key}) : super(key: key);

  final DateTime date;

  String _formatHour(DateTime date) {
    // DateFormat has no such method to extract only number from AM/PM hour format
    final dateHour12 = date.copyWith(hour: date.hour % 12);

    return DateFormat.Hm().format(dateHour12);
  }

  String _formateHourAmPm(DateTime date) {
    // DateFormat/DateTime has no such method to find out if hour is AM or PM
    return date.hour >= 12 ? 'PM' : 'AM';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Text(
            _formatHour(date),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            _formateHourAmPm(date),
            style: context.textTheme.caption,
          ),
        ],
      ),
    );
  }
}
