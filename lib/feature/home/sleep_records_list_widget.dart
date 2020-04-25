import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sleeptracker/feature/home/records_list_notifiers.dart';
import 'package:sleeptracker/i18n/i18n.dart';
import 'package:sleeptracker/repositories/sleep_records_repo.dart';
import 'package:sleeptracker/shared_widgets/duration_text.dart';
import 'package:sleeptracker/theme.dart';

class SleepRecordsList extends StatelessWidget {
  const SleepRecordsList({
    Key key,
  }) : super(key: key);

  static const _borderRadius = BorderRadius.vertical(
      top: Radius.circular(16), bottom: Radius.circular(16));

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: _borderRadius,
      elevation: 4,
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: Consumer<RecordsListNotifier>(
          builder: (context, state, _) {
            if (state.isLoading) {
              return const _LoadingRecordsWidget();
            } else if (state.records.isEmpty) {
              return const _NoRecordsWidget();
            }

            return ListView.separated(
              itemCount: 3,
              shrinkWrap: true,
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

class _NoRecordsWidget extends StatelessWidget {
  const _NoRecordsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(height: 16),
        Container(
          height: 148,
          child: const FlareActor(
            'assets/xiaoyu-nodata.flr',
            animation: 'idle',
          ),
        ),
        const SizedBox(height: 32),
        Text(I18n.noRecords),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _LoadingRecordsWidget extends StatelessWidget {
  const _LoadingRecordsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(height: 16),
        Container(
          height: 64,
          child: const FlareActor(
            'assets/loading-animation-sun-flare.flr',
            animation: 'active',
          ),
        ),
        const SizedBox(height: 32),
        Text(I18n.loadingRecords),
        const SizedBox(height: 16),
      ],
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

class SleepRecordDateWidget extends StatelessWidget {
  const SleepRecordDateWidget(this.date, {Key key}) : super(key: key);

  final DateTime date;

  List<String> _formatTime() {
    // jm: 8:55 AM
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
