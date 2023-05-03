import 'dart:io';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FilterOrderCaptainNotArrivedRequest {
  DateTime? toDate;
  DateTime? fromDate;
  FilterOrderCaptainNotArrivedRequest({this.fromDate, this.toDate});

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (toDate != null) {
      data['toDate'] = DateFormat('yyyy-MM-dd', 'en').format(toDate!);
    }
    if (fromDate != null) {
      data['fromDate'] = DateFormat('yyyy-MM-dd', 'en').format(fromDate!);
    }
     if (!kIsWeb) {
     data['customizedTimezone'] =
         await FlutterNativeTimezone.getLocalTimezone();
    }

    return data;
  }
}
