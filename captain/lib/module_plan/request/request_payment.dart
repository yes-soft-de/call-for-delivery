import 'dart:convert';

class RequestPayment {
  /// 0 not requested, 1 requested
  int status;

  RequestPayment({
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }

  factory RequestPayment.fromMap(Map<String, dynamic> map) {
    return RequestPayment(
      status: (map['status'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestPayment.fromJson(String source) =>
      RequestPayment.fromMap(json.decode(source) as Map<String, dynamic>);
}
