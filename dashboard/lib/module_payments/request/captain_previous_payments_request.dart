import 'dart:convert';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CaptainPreviousPaymentRequest {
  int captainId;
  int captainFinancialDuesId;
  DateTime? fromDate;
  DateTime? toDate;
  String? customizedTimezone;

  CaptainPreviousPaymentRequest({
    required this.captainId,
    required this.captainFinancialDuesId,
    this.fromDate,
    this.toDate,
  });

  Future<Map<String, dynamic>> toMap() async {
    customizedTimezone = await FlutterNativeTimezone.getLocalTimezone();
    return <String, dynamic>{
      'captainId': captainId,
      'captainFinancialDuesId': captainFinancialDuesId,
      if (fromDate != null) 'fromDate': fromDate?.toString(),
      if (toDate != null) 'toDate': toDate?.toString(),
      'customizedTimezone': customizedTimezone,
    };
  }

  String toJson() => json.encode(toMap());

  CaptainPreviousPaymentRequest copyWith({
    int? captainId,
    int? captainFinancialDuesId,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return CaptainPreviousPaymentRequest(
      captainId: captainId ?? this.captainId,
      captainFinancialDuesId: captainFinancialDuesId ?? this.captainFinancialDuesId,
      fromDate: (fromDate == DateTime(0)) ? null : fromDate ?? this.fromDate,
      toDate: (toDate == DateTime(0)) ? null : toDate ?? this.toDate,
    );
  }
}
