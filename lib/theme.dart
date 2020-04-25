import 'package:flutter/material.dart';

class ThemeProvider extends StatelessWidget {
  const ThemeProvider({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final primary = Colors.blue[900];

    return Theme(
      data: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: primary,
          onPrimary: Colors.white,
        ),
      ).copyWith(
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        dividerTheme: const DividerThemeData(
          space: 1,
          color: Colors.grey,
        ),
        iconTheme: IconThemeData(color: primary),
      ),
      isMaterialAppTheme: true,
      child: child,
    );
  }
}

extension ContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  Color get primaryColor => Theme.of(this).primaryColor;
}

extension TextStyleExtension on TextStyle {
  TextStyle get bolded => copyWith(fontWeight: FontWeight.bold);

  TextStyle colored(Color color) => copyWith(color: color);
}
