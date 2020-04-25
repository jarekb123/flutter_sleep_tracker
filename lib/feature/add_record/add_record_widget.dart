import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sleeptracker/feature/add_record/add_record_notifiers.dart';
import 'package:sleeptracker/i18n/i18n.dart';
import 'package:sleeptracker/repositories/sleep_records_repo.dart';
import 'package:sleeptracker/shared_widgets/buttons.dart';
import 'package:sleeptracker/shared_widgets/change_notifier_listener.dart';
import 'package:sleeptracker/shared_widgets/custom_icons.dart';
import 'package:sleeptracker/shared_widgets/duration_text.dart';
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
            Padding(
              padding: _horizontalPadding,
              child: Container(
                alignment: Alignment.center,
                height: 200,
                child: const FlareActor('assets/moon.flr', animation: 'go'),
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
  SleepType _sleepType = SleepType.night;
  Duration _duration;

  String _formatDate(DateTime date) {
    return DateFormat.yMMMMd().add_jm().format(date);
  }

  Future<void> _chooseDuration(BuildContext context) async {
    final duration = await showDurationPicker(
        context: context, initialTime: _duration ?? const Duration(hours: 6));
    setState(() {
      _duration = duration;
    });
  }

  Widget _saveButton(BuildContext context) {
    return ChangeNotifierListener<AddRecordNotifier>(
      listener: (context, addRecord) {
        switch (addRecord.addState) {
          case AddRecordState.loading:
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(I18n.loading)));
            break;
          case AddRecordState.success:
            Scaffold.of(context).hideCurrentSnackBar();
            Navigator.pop(context);
            break;
          case AddRecordState.error:
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(I18n.addRecordError)));
            break;
          default:
            break;
        }
      },
      child: Consumer<AddRecordNotifier>(
        builder: (_, addRecordNotifier, child) {
          return PrimaryButton(
            onPressed: _duration == null ||
                    addRecordNotifier.addState == AddRecordState.loading
                ? null
                : () {
                    addRecordNotifier.add(_sleepType, _duration);
                  },
            child: child,
          );
        },
        child: Text(I18n.save),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AddRecordNotifier>(
          builder: (context, addRecord, _) => _FormField(
            icon: const Icon(CustomIcons.calendar),
            title: Text(I18n.dateAndTime),
            subtitle: Text(_formatDate(addRecord.date)),
          ),
        ),
        const Divider(indent: 8, endIndent: 8),
        _FormField(
          icon: const Icon(CustomIcons.moon),
          title: Text(I18n.sleepType),
          subtitle:
              Text(_sleepType == SleepType.night ? I18n.nightSleep : I18n.nap),
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
          icon: const Icon(Icons.timer),
          title: Text(I18n.sleepDuration),
          subtitle:
              _duration != null ? DurationText(_duration) : const Text('-'),
          onTap: () => _chooseDuration(context),
        ),
        const Divider(indent: 8, endIndent: 8),
        const Spacer(),
        Padding(
          padding: _horizontalPadding,
          child: _saveButton(context),
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
    this.onTap,
  }) : super(key: key);

  final Widget icon;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        context.textTheme.bodyText1.colored(context.primaryColor);

    // center vertically leading icon
    // https://github.com/flutter/flutter/issues/28685#issuecomment-478130992
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 0,
        alignment: Alignment.center,
        child: IconTheme(
          data: IconThemeData(color: context.primaryColor),
          child: icon,
        ),
      ),
      title: DefaultTextStyle(style: titleStyle, child: title),
      subtitle: subtitle,
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
