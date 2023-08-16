import 'dart:convert';

class DeleteOrderFromAlShoroqRequest {
  int orderId;
  int externalCompanyId = 2;

  DeleteOrderFromAlShoroqRequest({
    required this.orderId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': orderId,
      'externalCompanyId': externalCompanyId,
    };
  }

  String toJson() => json.encode(toMap());
}
