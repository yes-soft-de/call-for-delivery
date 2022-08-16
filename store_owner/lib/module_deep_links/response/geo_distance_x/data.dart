import 'package:c4d/module_deep_links/response/geo_distance_x/cost_delivery_order_response/cost_delivery_order.dart';

class Data {
  String? distance;
  CostDeliveryOrder? costDeliveryOrder;

  Data({this.distance, this.costDeliveryOrder});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        distance: json['distance'] as String?,
        costDeliveryOrder: json['costDeliveryOrder'] == null
            ? null
            : CostDeliveryOrder.fromJson(
                json['costDeliveryOrder'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'distance': distance,
      };
}
