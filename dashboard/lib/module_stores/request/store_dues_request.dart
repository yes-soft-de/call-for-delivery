// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StoreDuesRequest {
  int storeOwnerProfileId;
  String? year;

  StoreDuesRequest({
    required this.storeOwnerProfileId,
    this.year,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storeOwnerProfileId': storeOwnerProfileId,
      'year': year,
    };
  }

  factory StoreDuesRequest.fromMap(Map<String, dynamic> map) {
    return StoreDuesRequest(
      storeOwnerProfileId: (map['storeOwnerProfileId'] ?? 0) as int,
      year: map['year'] != null ? map['year'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreDuesRequest.fromJson(String source) =>
      StoreDuesRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
