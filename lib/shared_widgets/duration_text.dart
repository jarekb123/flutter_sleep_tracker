import 'package:flutter/widgets.dart';
import 'package:sleeptracker/i18n/i18n.dart';

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