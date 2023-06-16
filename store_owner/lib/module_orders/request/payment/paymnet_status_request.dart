import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentStatusRequest {
  /// 0 not paid, 1 paid success
  int status;

  PaymentStatusRequest({
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }

  factory PaymentStatusRequest.fromMap(Map<String, dynamic> map) {
    return PaymentStatusRequest(
      status: (map['status'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentStatusRequest.fromJson(String source) =>
      PaymentStatusRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
