import 'dart:io';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';

class FilterOrderRequest {
  String? state;
  DateTime? toDate;
  DateTime? fromDate;
  FilterOrderRequest({this.fromDate, this.state, this.toDate});

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.state != null) {
      data['state'] = this.state;
    }
    if (toDate != null) {
      data['toDate'] = DateFormat('yyyy-MM-dd', 'en').format(toDate!);
    }
    if (fromDate != null) {
      data['fromDate'] = DateFormat('yyyy-MM-dd', 'en').format(fromDate!);
    }
    if (Platform.isAndroid || Platform.isIOS) {
      data['customizedTimezone'] =
          await FlutterNativeTimezone.getLocalTimezone();
    }

    return data;
  }
}
