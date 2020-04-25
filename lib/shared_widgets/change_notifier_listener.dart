import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeNotifierListener<T extends ChangeNotifier> extends StatefulWidget {
  const ChangeNotifierListener({
    Key key,
    @required this.child,
    @required this.listener,
    this.changeNotifier,
  }) : super(key: key);

  final Widget child;
  final Function(BuildContext, T) listener;
  final T changeNotifier;

  @override
  _ChangeNotifierListenerState createState() =>
      _ChangeNotifierListenerState<T>();
}

class _ChangeNotifierListenerState<T extends ChangeNotifier>
    extends State<ChangeNotifierListener<T>> {
  T _changeNotifier;

  @override
  void initState() {
    super.initState();
    _changeNotifier =
        widget.changeNotifier ?? Provider.of<T>(context, listen: false);
    _changeNotifier.addListener(_listener);
  }

  @override
  void dispose() {
    _changeNotifier.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    widget.listener(context, _changeNotifier);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
