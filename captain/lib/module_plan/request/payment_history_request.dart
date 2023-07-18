import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentHistoryRequest {
  int storeOwnerProfileId;
  DateTime? fromDate;
  DateTime? toDate;
  String? customizedTimezone;

  PaymentHistoryRequest({
    required this.storeOwnerProfileId,
    this.fromDate,
    this.toDate,
    this.customizedTimezone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storeOwnerProfileId': storeOwnerProfileId,
      if (fromDate != null) 'fromDate': fromDate?.toString(),
      if (toDate != null) 'toDate': toDate?.toString(),
      'customizedTimezone': customizedTimezone,
    };
  }

  String toJson() => json.encode(toMap());

  PaymentHistoryRequest copyWith({
    int? storeOwnerProfileId,
    DateTime? fromDate,
    DateTime? toDate,
    String? customizedTimezone,
  }) {
    return PaymentHistoryRequest(
      storeOwnerProfileId: storeOwnerProfileId ?? this.storeOwnerProfileId,
      fromDate: (fromDate == DateTime(0)) ? null : fromDate ?? this.fromDate,
      toDate: (toDate == DateTime(0)) ? null : toDate ?? this.toDate,
      customizedTimezone: customizedTimezone ?? this.customizedTimezone,
    );
  }
}
