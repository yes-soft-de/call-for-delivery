// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class CaptainPaymentRequest {
  int? captainProfileId;
  // 2 not paid
  int? status;
  bool? hasCaptainFinancialDueDemanded;

  CaptainPaymentRequest({
    this.captainProfileId,
    this.status,
    this.hasCaptainFinancialDueDemanded,
  });

  Future<Map<String, dynamic>> toMap() async {
    return <String, dynamic>{
      'customizedTimezone': await FlutterNativeTimezone.getLocalTimezone(),
      if (captainProfileId != null) 'captainProfileId': captainProfileId,
      if (status != null) 'status': status,
      if (hasCaptainFinancialDueDemanded != null)
        'hasCaptainFinancialDueDemanded': hasCaptainFinancialDueDemanded,
    };
  }

  String toJson() => json.encode(toMap());
}
