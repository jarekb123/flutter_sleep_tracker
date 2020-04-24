import 'package:flutter/material.dart';

class ThemeProvider extends StatelessWidget {
  const ThemeProvider({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Colors.blue[900],
          onPrimary: Colors.white,
        ),
      ).copyWith(
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      isMaterialAppTheme: true,
      child: child,
    );
  }
}
