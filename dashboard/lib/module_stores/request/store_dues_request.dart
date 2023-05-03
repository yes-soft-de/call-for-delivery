import 'dart:convert';

class StoreDuesRequest {
  int StoreOwnerProfileId;
  String fromDate;
  String toDate;
  String isPaid;

  StoreDuesRequest({
    required this.StoreOwnerProfileId,
    required this.fromDate,
    required this.toDate,
    required this.isPaid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'StoreOwnerProfileId': StoreOwnerProfileId,
      'fromDate': fromDate,
      'toDate': toDate,
      'isPaid': isPaid,
    };
  }

  factory StoreDuesRequest.fromMap(Map<String, dynamic> map) {
    return StoreDuesRequest(
      StoreOwnerProfileId: (map['StoreOwnerProfileId'] ?? 0) as int,
      fromDate: (map['fromDate'] ?? '') as String,
      toDate: (map['toDate'] ?? '') as String,
      isPaid: (map['isPaid'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreDuesRequest.fromJson(String source) =>
      StoreDuesRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
