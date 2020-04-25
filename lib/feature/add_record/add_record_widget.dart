import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleeptracker/feature/add_record/add_record_notifiers.dart';
import 'package:sleeptracker/repositories/sleep_records_repo.dart';
import 'package:sleeptracker/shared_widgets/buttons.dart';
import 'package:sleeptracker/theme.dart';
import 'package:sleeptracker/utils/provider_utils.dart';

const _horizontalPadding = EdgeInsets.symmetric(horizontal: 16);

class AddRecordWidget extends StatelessWidget {
  const AddRecordWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddRecordNotifier(inject(context), inject(context)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sleep Tracker'),
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            const Padding(
              padding: _horizontalPadding,
              child: Placeholder(
                fallbackHeight: 200,
              ),
            ),
            const SizedBox(height: 32),
            const Expanded(child: _AddRecordForm()),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _AddRecordForm extends StatefulWidget {
  const _AddRecordForm({
    Key key,
  }) : super(key: key);

  @override
  __AddRecordFormState createState() => __AddRecordFormState();
}

class __AddRecordFormState extends State<_AddRecordForm> {
  SleepType _sleepType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AddRecordNotifier>(
          builder: (context, addRecord, _) => _FormField(
            icon: Icon(Icons.calendar_today),
            title: 'Date and time',
            subtitle: '${addRecord.date}',
          ),
        ),
        const Divider(indent: 8, endIndent: 8),
        _FormField(
          icon: Icon(Icons.mic),
          title: 'Sleep type',
          subtitle: '29 November 2019',
          trailing: _SleepTypeSwitch(
            value: _sleepType == SleepType.nap,
            onChanged: (isNap) {
              setState(() {
                _sleepType = isNap ? SleepType.nap : SleepType.night;
              });
            },
          ),
        ),
        const Divider(indent: 8, endIndent: 8),
        _FormField(
          icon: Icon(Icons.timer),
          title: 'Sleep duration',
          subtitle: '29 November 2019',
        ),
        const Divider(indent: 8, endIndent: 8),
        const Spacer(),
        Padding(
          padding: _horizontalPadding,
          child: PrimaryButton(
            onPressed: () {},
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }
}

class _SleepTypeSwitch extends StatefulWidget {
  const _SleepTypeSwitch({
    Key key,
    @required this.onChanged,
    @required this.value,
  }) : super(key: key);

  final ValueChanged<bool> onChanged;
  final bool value;

  static const _trueAnimation = 'day_idle';
  static const _falseAnimation = 'night_idle';
  static const _falseToTrueAnimation = 'switch_day';
  static const _trueToFalseAnimation = 'switch_night';

  @override
  __SleepTypeSwitchState createState() => __SleepTypeSwitchState();
}

class __SleepTypeSwitchState extends State<_SleepTypeSwitch> {
  String _animation;

  @override
  void initState() {
    _animation = widget.value
        ? _SleepTypeSwitch._trueAnimation
        : _SleepTypeSwitch._falseAnimation;
    super.initState();
  }

  @override
  void didUpdateWidget(_SleepTypeSwitch oldWidget) {
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        setState(() {
          _animation = _SleepTypeSwitch._falseToTrueAnimation;
        });
      } else {
        setState(() {
          _animation = _SleepTypeSwitch._trueToFalseAnimation;
        });
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: FlareActor(
        'assets/switch_daytime.flr',
        animation: _animation,
        alignment: Alignment.center,
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    this.trailing,
  }) : super(key: key);

  final Widget icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        context.textTheme.bodyText1.colored(context.primaryColor);

    // center vertically leading icon
    // https://github.com/flutter/flutter/issues/28685#issuecomment-478130992
    return ListTile(
      leading: Container(
        width: 0,
        alignment: Alignment.center,
        child: IconTheme(
          data: IconThemeData(color: context.primaryColor),
          child: icon,
        ),
      ),
      title: Text(title, style: titleStyle),
      subtitle: Text(subtitle),
      trailing: trailing != null
          ? Container(
              width: 48,
              alignment: Alignment.center,
              child: IconTheme(
                data: IconThemeData(color: context.primaryColor),
                child: trailing,
              ),
            )
          : null,
    );
  }
}
