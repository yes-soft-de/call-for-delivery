import 'dart:io';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:intl/intl.dart';

class SpecificCaptainActivityFilterRequest {
  int? captainId;
  String? state;
  String? payment;
  DateTime? toDate;
  DateTime? fromDate;
  SpecificCaptainActivityFilterRequest({
    this.captainId,
    this.payment,
    this.fromDate,
    this.state,
    this.toDate,
  });

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.captainId != null) {
      data['captainId'] = this.captainId;
    }
    if (this.payment != null) {
      data['payment'] = this.payment;
    }
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
