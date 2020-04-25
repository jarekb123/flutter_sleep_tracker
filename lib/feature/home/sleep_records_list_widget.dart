import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sleeptracker/feature/home/records_list_notifiers.dart';
import 'package:sleeptracker/i18n/i18n.dart';
import 'package:sleeptracker/repositories/sleep_records_repo.dart';
import 'package:sleeptracker/theme.dart';

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
                    duration: const Duration(hours: 1),
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
    final sleepType =
        sleepRecord.sleepType == SleepType.nap ? I18n.nap : I18n.nightSleep;

    return Row(
      children: <Widget>[
        SleepRecordDateWidget(sleepRecord.createdAt),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              sleepType,
              style: context.textTheme.bodyText1.colored(context.primaryColor),
            ),
            DurationText(sleepRecord.duration),
          ],
        )
      ],
    );
  }
}

class DurationText extends StatelessWidget {
  const DurationText(
    this.duration, {
    Key key,
  }) : super(key: key);

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final hours = I18n.hours(duration.inHours);
    final minutes = I18n.minutes(duration.inMinutes % 60);

    return Text('$hours $minutes');
  }
}

class SleepRecordDateWidget extends StatelessWidget {
  const SleepRecordDateWidget(this.date, {Key key}) : super(key: key);

  final DateTime date;

  List<String> _formatTime() {
    final formattedTime = DateFormat.jm().format(date).toUpperCase().split(' ');

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = _formatTime();

    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Text(
            formattedTime[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            formattedTime[1],
            style: context.textTheme.caption,
          ),
        ],
      ),
    );
  }
}
