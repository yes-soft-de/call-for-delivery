import 'package:c4d/generated/l10n.dart';
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

String getMonthFName(int month) {
  switch (month) {
    case 1:
      return S.current.fJanuary;
    case 2:
      return S.current.fFebruary;
    case 3:
      return S.current.fMarch;
    case 4:
      return S.current.fApril;
    case 5:
      return S.current.fMay;
    case 6:
      return S.current.fJune;
    case 7:
      return S.current.fJuly;
    case 8:
      return S.current.fAugust;
    case 9:
      return S.current.fSeptember;
    case 10:
      return S.current.fOctober;
    case 11:
      return S.current.fNovember;
    case 12:
      return S.current.fDecember;
  }
  return '';
}

DateTime getLastDayOnMonth(DateTime time) {
  var lastDayDateTime = new DateTime(time.year, time.month + 1, 0);
  return lastDayDateTime;
}
