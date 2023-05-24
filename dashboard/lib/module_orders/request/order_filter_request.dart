import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FilterOrderRequest {
  String? state;
  DateTime? toDate;
  DateTime? fromDate;
  String? captainID;
  String? payment;
  String? orderId;
  bool? isResolved;
  FilterOrderRequest({
    this.isResolved,
    this.fromDate,
    this.state,
    this.toDate,
    this.captainID,
    this.orderId,
  });

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.isResolved != null) {
      data['isResolved'] = this.isResolved;
    }
    if (this.orderId != null) {
      data['orderId'] = this.orderId;
    }
    if (this.state != null) {
      data['state'] = this.state;
    }
    if (this.captainID != null) {
      data['captainId'] = this.captainID;
    }
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
    if (payment != null) {
      data['payment'] = this.payment == S.current.card
          ? 'card'
          : (this.payment == S.current.cash ? 'cash' : 'all');
    }
    return data;
  }
}
