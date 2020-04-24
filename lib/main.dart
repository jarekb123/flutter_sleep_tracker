import 'package:flutter/material.dart';
import 'package:sleeptracker/feature/home/home_widget.dart';
import 'package:sleeptracker/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      builder: (context, widget) {
        return ThemeProvider(child: widget);
      },
      home: const HomeWidget(),
    );
  }
}
