import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateNewDeliveryCompanyRequest {
  String companyName;
  bool status;
  CreateNewDeliveryCompanyRequest({
    required this.companyName,
    this.status = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyName': companyName,
      'status': status,
    };
  }

  factory CreateNewDeliveryCompanyRequest.fromMap(Map<String, dynamic> map) {
    return CreateNewDeliveryCompanyRequest(
      companyName: (map['companyName'] ?? '') as String,
      status: (map['status'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateNewDeliveryCompanyRequest.fromJson(String source) =>
      CreateNewDeliveryCompanyRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
