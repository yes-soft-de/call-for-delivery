class DateHelper {
  static DateTime convert(int? timeStamp,[bool isUtc = true]) {
    timeStamp ??= 0;
    var date =
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000, isUtc: isUtc);
    return date;
  }
}
