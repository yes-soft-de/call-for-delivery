import 'dart:convert';

class DeleteOrderFromMarsoolRequest {
  int orderId;

  DeleteOrderFromMarsoolRequest({
    required this.orderId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
    };
  }

  String toJson() => json.encode(toMap());
}
