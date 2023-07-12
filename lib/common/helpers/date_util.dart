import 'package:intl/intl.dart';

String? getStrDate(DateTime? date, {String? pattern, String? locale}) {
  DateFormat defaultFormat = locale != null
      ? DateFormat('dd/MM/yyyy', locale)
      : DateFormat('dd/MM/yyyy');

  if (date == null || date.millisecondsSinceEpoch == 0) {
    return null;
  }

  DateFormat? format;
  if (pattern != null) {
    try {
      format =
      locale != null ? DateFormat(pattern, locale) : DateFormat(pattern);
    } on Exception catch (e) {
      throw ('errorDatePattern: $e');
    }
  }

  String formattedDate;
  if (format != null) {
    formattedDate = format.format(date);
  } else {
    formattedDate = defaultFormat.format(date);
  }
  return formattedDate;
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

String? getDayDisplay(DateTime dateTime) {
  if (DateTime.now().day == dateTime.day) {
    return "today";
  } else if (DateTime.now().difference(dateTime) < Duration(days: 7)) {
    return getStrDate(dateTime, pattern: 'EEEE');
  } else {
    return getStrDate(dateTime, pattern: 'dd-MM-yyyy');
  }
}

DateTime getTodayGivenTime(String time) {
  int hours = int.tryParse(time.substring(0, 2))!;
  int minutes = int.tryParse(time.substring(3, 5))!;

  DateTime now = DateTime.now();
  DateTime dt = DateTime(now.year, now.month, now.day, hours, minutes, 0, 0, 0);

  return dt;
}

class DateRange {
  DateTime? from;
  DateTime? to;

  DateRange({
    this.from,
    this.to,
  });

  /// Generates a Daterange for the current week from monday till sunday
  factory DateRange.thisWeek() {
    DateTime now = DateTime.now();
    int weekDay = now.weekday;
    DateTime start = now.subtract(Duration(days: weekDay - 1));
    DateTime end = now.add(Duration(days: 7 - weekDay));
    return DateRange(
      from: DateTime(start.year, start.month, start.day),
      to: DateTime(end.year, end.month, end.day, 23, 59, 59),
    );
  }

  /// Generates a Daterange for the current month
  factory DateRange.thisMonth() {
    DateTime now = DateTime.now();
    return DateRange(
      from: DateTime(now.year, now.month),
      // Fix "to" day may not be 30
      to: DateTime(now.year, now.month, 30),
    );
  }

  /// Generates a Daterange for the current year
  factory DateRange.thisYear() {
    DateTime now = DateTime.now();
    return DateRange(
      from: DateTime(now.year, 1, 1),
      // Fix "to" day may not be 30
      to: DateTime(now.year, 12, 30),
    );
  }
}
