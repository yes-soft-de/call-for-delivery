import 'package:intl/intl.dart';

bool isDateToday(String date, [String? format]) {
  DateTime now = DateTime.now();
  String today = DateFormat(format ?? 'yyyy/MM/dd', 'en').format(now);
  if (today == date) {
    return true;
  } else {
    return false;
  }
}

bool isDateYesterday(String date, [String? format]) {
  DateTime now = DateTime.now();
  DateTime yesterdayDate = DateTime(now.year, now.month, now.day - 1);
  String yesterday =
      DateFormat(format ?? 'yyyy/MM/dd', 'en').format(yesterdayDate);
  if (yesterday == date) {
    return true;
  } else {
    return false;
  }
}

String getDateFromUTCAsString(DateTime date) {
  return DateFormat('yyyy/MM/dd', 'en').format(date);
}

String getTimeFromUTCAsString(DateTime date) {
  return DateFormat('hh:mm a', 'en').format(date);
}
