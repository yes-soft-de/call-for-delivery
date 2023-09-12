import 'dart:convert';

class DeleteOrderFromNaherEvanRequest {
  int orderId;

  DeleteOrderFromNaherEvanRequest({
    required this.orderId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
    };
  }

  String toJson() => json.encode(toMap());
}
