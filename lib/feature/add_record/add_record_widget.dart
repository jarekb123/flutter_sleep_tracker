import 'package:flutter/material.dart';
import 'package:sleeptracker/shared_widgets/buttons.dart';
import 'package:sleeptracker/theme.dart';

const _horizontalPadding = EdgeInsets.symmetric(horizontal: 16);

class AddRecordWidget extends StatelessWidget {
  const AddRecordWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

class _AddRecordForm extends StatelessWidget {
  const _AddRecordForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FormField(
          icon: Icon(Icons.calendar_today),
          title: 'Date and time',
          subtitle: '29 November 2019',
        ),
        const Divider(indent: 8, endIndent: 8),
        _FormField(
          icon: Icon(Icons.mic),
          title: 'Sleep type',
          subtitle: '29 November 2019',
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

class _FormField extends StatelessWidget {
  const _FormField({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  final Widget icon;
  final String title;
  final String subtitle;

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
    );
  }
}
