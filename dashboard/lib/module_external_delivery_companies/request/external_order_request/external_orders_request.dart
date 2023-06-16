import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExternalOrderRequest {
  int externalCompanyId;
  String? storeOwnerProfileId;
  String? storeBranchId;
  DateTime? toDate;
  DateTime? fromDate;

  ExternalOrderRequest({
    this.externalCompanyId = 0,
    this.storeOwnerProfileId,
    this.storeBranchId,
    this.toDate,
    this.fromDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'externalCompanyId': externalCompanyId,
      if (storeOwnerProfileId != null)
        'storeOwnerProfileId': storeOwnerProfileId,
      if (storeBranchId != null) 'storeBranchId': storeBranchId,
      if (toDate != null) 'toDate': toDate.toString(),
      if (fromDate != null) 'fromDate': fromDate.toString(),
    };
  }

  factory ExternalOrderRequest.fromMap(Map<String, dynamic> map) {
    return ExternalOrderRequest(
      externalCompanyId: (map['externalCompanyId'] ?? 0) as int,
      storeOwnerProfileId: map['storeOwnerProfileId'] != null
          ? map['storeOwnerProfileId'] as String
          : null,
      storeBranchId:
          map['storeBranchId'] != null ? map['storeBranchId'] as String : null,
      toDate: map['toDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['toDate'] ?? 0) as int)
          : null,
      fromDate: map['fromDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['fromDate'] ?? 0) as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExternalOrderRequest.fromJson(String source) =>
      ExternalOrderRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
