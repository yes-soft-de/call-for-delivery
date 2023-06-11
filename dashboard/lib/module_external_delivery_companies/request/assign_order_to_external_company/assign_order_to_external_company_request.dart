import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AssignOrderToExternalCompanyRequest {
  final int companyId;
  final int orderId;

  AssignOrderToExternalCompanyRequest({
    required this.companyId,
    required this.orderId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyId': companyId,
      'orderId': orderId,
    };
  }

  factory AssignOrderToExternalCompanyRequest.fromMap(
      Map<String, dynamic> map) {
    return AssignOrderToExternalCompanyRequest(
      companyId: (map['companyId'] ?? 0) as int,
      orderId: (map['orderId'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignOrderToExternalCompanyRequest.fromJson(String source) =>
      AssignOrderToExternalCompanyRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
