import 'cost_delivery_order.dart';

class CostDeliveryOrderResponse {
  CostDeliveryOrder? costDeliveryOrder;

  CostDeliveryOrderResponse({this.costDeliveryOrder});

  factory CostDeliveryOrderResponse.fromJson(Map<String, dynamic> json) {
    return CostDeliveryOrderResponse(
      costDeliveryOrder: json['costDeliveryOrder'] == null
          ? null
          : CostDeliveryOrder.fromJson(
              json['costDeliveryOrder'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'costDeliveryOrder': costDeliveryOrder?.toJson(),
      };
}
