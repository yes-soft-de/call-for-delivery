// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:c4d/module_deep_links/response/geo_distance_x/cost_delivery_order_response/cost_delivery_order.dart';
import 'package:latlong2/latlong.dart';

class Data {
  String? distance;
  CostDeliveryOrder? costDeliveryOrder;
  LatLng? destination;

  Data({
    this.distance,
    this.costDeliveryOrder,
    this.destination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      distance: json['distance'] as String?,
      costDeliveryOrder: json['costDeliveryOrder'] == null
          ? null
          : CostDeliveryOrder.fromJson(
              json['costDeliveryOrder'] as Map<String, dynamic>),
      destination: extractFromList(json['destination'] as List?));
}

LatLng? extractFromList(List? list) {
  if (list == null)
    return null;
  else if (list.length < 2) return null;

  return LatLng(list[0].toDouble(), list[1].toDouble());
}
