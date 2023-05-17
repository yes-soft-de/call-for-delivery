import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class CaptainDailyFinanceRequest {
  DateTime? fromDate;
  DateTime? toDate;
  int? captainProfileId;
  int? isPaid;

  CaptainDailyFinanceRequest(
      {this.fromDate, this.toDate, this.captainProfileId, this.isPaid});

  factory CaptainDailyFinanceRequest.fromJson(Map<String, dynamic> json) {
    return CaptainDailyFinanceRequest(
      fromDate: json['fromDate'] == null
          ? null
          : DateTime.parse(json['fromDate'] as String),
      toDate: json['toDate'] == null
          ? null
          : DateTime.parse(json['toDate'] as String),
      captainProfileId: json['captainProfileId'] as int?,
      isPaid: json['isPaid'] as int?,
    );
  }

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
    if (captainProfileId != null) {
      data['captainProfileId'] = captainProfileId;
    }
    if (isPaid != null) {
      data['isPaid'] = isPaid;
    }
    return data;
  }
}
