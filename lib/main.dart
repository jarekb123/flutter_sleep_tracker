import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleeptracker/feature/home/home_widget.dart';
import 'package:sleeptracker/theme.dart';
import 'package:sleeptracker/utils/date_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalProviders(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        builder: (context, widget) {
          return ThemeProvider(child: widget);
        },
        home: const HomeWidget(),
      ),
    );
  }
}

class GlobalProviders extends StatelessWidget {
  const GlobalProviders({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider.value(value: DateUtils())],
      child: child,
    );
  }
}
