import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sleeptracker/feature/home/records_list_notifiers.dart';
import 'package:sleeptracker/shared_widgets/buttons.dart';
import 'package:sleeptracker/utils/date_utils.dart';
import 'package:sleeptracker/theme.dart';
import 'package:sleeptracker/utils/provider_utils.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecordsListNotifier(inject(context)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sleep Tracker'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Get to know your baby\'s sleep patterns and keep track of how much sleep they are getting here.',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                onPressed: () {},
                child: const Text('Add new sleeping record'),
              ),
              const SizedBox(height: 80),
              const CurrentDateHeader(),
              const SizedBox(height: 32),
              const Expanded(
                child: SleepRecordsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        child: ListView.separated(
          itemCount: 3,
          itemBuilder: (context, index) {
            return SleepRecordWidget();
          },
          separatorBuilder: (_, __) => const Divider(height: 1),
        ),
      ),
    );
  }
}

class SleepRecordWidget extends StatelessWidget {
  const SleepRecordWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Text(
                '10:42',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'PM',
                style: context.textTheme.caption,
              ),
            ],
          ),
        ),
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

class CurrentDateHeader extends StatelessWidget {
  const CurrentDateHeader({Key key}) : super(key: key);

  String _formatDate(DateTime date) {
    return DateFormat('EEEE, d MMM y').format(date).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final DateUtils dateUtils = Provider.of(context);

    return Text(
      _formatDate(dateUtils.now()),
      style: Theme.of(context).textTheme.subhead.bolded,
    );
  }
}
