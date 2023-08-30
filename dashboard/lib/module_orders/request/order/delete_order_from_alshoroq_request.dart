import 'dart:convert';

class DeleteOrderFromAlShoroqRequest {
  int orderId;
  int externalCompanyId = 2;

  DeleteOrderFromAlShoroqRequest({
    required this.orderId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'externalCompanyId': externalCompanyId,
    };
  }

  String toJson() => json.encode(toMap());
}
