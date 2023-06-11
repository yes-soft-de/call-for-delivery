import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateDeliveryCompanyRequest {
  int id;
  String companyName;
  UpdateDeliveryCompanyRequest({
    required this.id,
    required this.companyName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyName': companyName,
    };
  }

  factory UpdateDeliveryCompanyRequest.fromMap(Map<String, dynamic> map) {
    return UpdateDeliveryCompanyRequest(
      id: (map['id'] ?? 0) as int,
      companyName: (map['companyName'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateDeliveryCompanyRequest.fromJson(String source) =>
      UpdateDeliveryCompanyRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
