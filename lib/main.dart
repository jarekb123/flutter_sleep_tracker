import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleeptracker/feature/add_record/add_record_widget.dart';
import 'package:sleeptracker/feature/home/home_widget.dart';
import 'package:sleeptracker/local_repositories/memory_sleep_records_repo.dart';
import 'package:sleeptracker/repositories/sleep_records_repo.dart';
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
      providers: [
        Provider.value(value: DateUtils()),
        Provider<SleepRecordsRepo>(
            create: (context) => MemorySleepRecordsRepo())
      ],
      child: child,
    );
  }
}
