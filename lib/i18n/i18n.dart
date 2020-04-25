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

  String get loadingRecords;
  String get noRecords;

  String hours(int hours);
  String minutes(int minutes);

  String get nap;
  String get nightSleep;

  // form
  String get dateAndTime;
  String get sleepType;
  String get sleepDuration;
  String get save;
  String get addingRecord;
  String get addRecordError;
}

class _EnI18n implements _I18n {
  @override
  String get loadingRecords => 'Loading sleeping records...';
  
  @override
  String get noRecords => 'No records added :(';

  @override
  String hours(int hours) => Intl.plural(hours,
      zero: '$hours hours', one: '$hours hour', other: '$hours hours');

  @override
  String minutes(int minutes) => Intl.plural(minutes,
      zero: '$minutes minutes',
      one: '$minutes minute',
      other: '$minutes minutes');

  @override
  String get nap => 'Nap';

  @override
  String get nightSleep => 'Night\'s Sleep';

  @override
  String get dateAndTime => 'Date and Time';

  @override
  String get sleepDuration => 'Sleep Duration';

  @override
  String get sleepType => 'Sleep Type';

  @override
  String get save => 'Save';

  @override
  String get addRecordError => 'Error: Try again';

  @override
  String get addingRecord => 'Your record is being added...';
}
