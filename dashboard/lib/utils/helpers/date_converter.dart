class DateHelper {
  static DateTime convert(int? timeStamp) {
    timeStamp ??= 0;
    var date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return date;
  }

  static DateTime convertUTC(int? timeStamp) {
    timeStamp ??= 0;
    var date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000, isUtc: true);
    return date;
  }
}
