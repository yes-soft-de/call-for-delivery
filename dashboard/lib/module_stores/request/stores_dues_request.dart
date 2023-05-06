import 'dart:convert';

class StoresDuesRequest {
  /// '1' paid / '2' not paid
  String isPaid;

  StoresDuesRequest({
    this.isPaid = '2',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isPaid': isPaid,
    };
  }

  factory StoresDuesRequest.fromMap(Map<String, dynamic> map) {
    return StoresDuesRequest(
      isPaid: (map['isPaid'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoresDuesRequest.fromJson(String source) =>
      StoresDuesRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
