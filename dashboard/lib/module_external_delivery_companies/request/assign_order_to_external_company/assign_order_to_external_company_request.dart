import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AssignOrderToExternalCompanyRequest {
  final int externalCompanyId;
  final int orderId;

  AssignOrderToExternalCompanyRequest({
    required this.externalCompanyId,
    required this.orderId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'externalCompanyId': externalCompanyId,
      'orderId': orderId,
    };
  }

  factory AssignOrderToExternalCompanyRequest.fromMap(
      Map<String, dynamic> map) {
    return AssignOrderToExternalCompanyRequest(
      externalCompanyId: (map['externalCompanyId'] ?? 0) as int,
      orderId: (map['orderId'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignOrderToExternalCompanyRequest.fromJson(String source) =>
      AssignOrderToExternalCompanyRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
