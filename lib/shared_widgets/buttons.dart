import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key key, @required this.onPressed, @required this.child})
      : super(key: key);

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(40);

    return RaisedButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      padding: EdgeInsets.zero,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 1],
            colors: [
              Theme.of(context).primaryColor,
              Colors.blue[500],
            ],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
