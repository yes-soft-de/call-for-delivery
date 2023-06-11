import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DeleteDeliveryCompanyRequest {
  int id;
  DeleteDeliveryCompanyRequest({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory DeleteDeliveryCompanyRequest.fromMap(Map<String, dynamic> map) {
    return DeleteDeliveryCompanyRequest(
      id: (map['id'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeleteDeliveryCompanyRequest.fromJson(String source) =>
      DeleteDeliveryCompanyRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
