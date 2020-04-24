import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

T inject<T>(BuildContext context) => Provider.of(context, listen: false);
