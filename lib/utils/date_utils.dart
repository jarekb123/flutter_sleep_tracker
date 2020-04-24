class DateUtils {
  DateTime now() => DateTime.now();

  DateTime nowUtc() => now().toUtc();
}

extension DateTimeExtension on DateTime {
  DateTime copyWith(
      {int year, int month, int day, int hour, int minute, int second}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
    );
  }
}
