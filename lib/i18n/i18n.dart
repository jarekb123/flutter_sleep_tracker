import 'package:intl/intl.dart';

// ignore: non_constant_identifier_names
final _I18n I18n = _I18n();

abstract class _I18n {
  factory _I18n() {
    if (Intl.defaultLocale == 'en') {
      return _EnI18n();
    }

    // default i18n
    return _EnI18n();
  }

  String hours(int hours);
  String minutes(int minutes);
}

class _EnI18n implements _I18n {
  @override
  String hours(int hours) => Intl.plural(hours,
      zero: '$hours hours', one: '$hours hour', other: '$hours hours');

  @override
  String minutes(int minutes) => Intl.plural(minutes,
      zero: '$minutes minutes',
      one: '$minutes minute',
      other: '$minutes minutes');
}
