// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:c4d/module_deep_links/response/geo_distance_x/cost_delivery_order_response/cost_delivery_order.dart';

class Data {
  String? distance;
  CostDeliveryOrder? costDeliveryOrder;
  List<GeoRes>? destination;

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
      destination: (json['destination'] as List<Map<String, dynamic>>?)?.map(
        (e) {
          return GeoRes.fromMap(e);
        },
      ).toList());
}

class GeoRes {
  double? lat;
  double? lon;
  String? link;

  GeoRes({
    this.lat,
    this.lon,
    this.link,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
      'link': link,
    };
  }

  factory GeoRes.fromMap(Map<String, dynamic> map) {
    return GeoRes(
      lat: map['lat'] != null ? map['lat'] as double : null,
      lon: map['lon'] != null ? map['lon'] as double : null,
      link: map['link'] != null ? map['link'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoRes.fromJson(String source) =>
      GeoRes.fromMap(json.decode(source) as Map<String, dynamic>);
}
