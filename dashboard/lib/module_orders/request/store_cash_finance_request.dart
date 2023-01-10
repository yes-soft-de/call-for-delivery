import 'dart:io';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';

class StoreCashFinanceRequest {
  String? storeId;
  DateTime? toDate;
  DateTime? fromDate;
  StoreCashFinanceRequest({this.fromDate, this.storeId, this.toDate});

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['storeId'] = this.storeId;
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
