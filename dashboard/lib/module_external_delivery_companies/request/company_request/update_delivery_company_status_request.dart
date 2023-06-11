import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateDeliveryCompanyStatusRequest {
  int id;
  bool status;

  UpdateDeliveryCompanyStatusRequest({
    required this.id,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
    };
  }

  factory UpdateDeliveryCompanyStatusRequest.fromMap(Map<String, dynamic> map) {
    return UpdateDeliveryCompanyStatusRequest(
      id: (map['id'] ?? 0) as int,
      status: (map['status'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateDeliveryCompanyStatusRequest.fromJson(String source) =>
      UpdateDeliveryCompanyStatusRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
