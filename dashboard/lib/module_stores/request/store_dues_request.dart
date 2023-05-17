// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StoreDuesRequest {
  int storeOwnerProfileId;
  String? year;
  String? isPaid;

  StoreDuesRequest({
    required this.storeOwnerProfileId,
    this.year,
    this.isPaid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storeOwnerProfileId': storeOwnerProfileId,
      'year': year,
      if (isPaid != null) 'isPaid': isPaid,
    };
  }

  factory StoreDuesRequest.fromMap(Map<String, dynamic> map) {
    return StoreDuesRequest(
      storeOwnerProfileId: (map['storeOwnerProfileId'] ?? 0) as int,
      year: map['year'] != null ? map['year'] as String : null,
      isPaid: map['isPaid'] != null ? map['isPaid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreDuesRequest.fromJson(String source) =>
      StoreDuesRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
