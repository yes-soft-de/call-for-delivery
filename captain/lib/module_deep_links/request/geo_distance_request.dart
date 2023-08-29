// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:latlong2/latlong.dart';

class GeoDistanceRequest {
  LatLng origin;
  LatLng distance;

  GeoDistanceRequest({
    required this.origin,
    required this.distance,
  });

  GeoDistanceRequest copyWith({
    LatLng? origin,
    LatLng? distance,
  }) {
    return GeoDistanceRequest(
      origin: origin ?? this.origin,
      distance: distance ?? this.distance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'origin': origin.toJson(),
      'distance': distance.toJson(),
    };
  }

  factory GeoDistanceRequest.fromMap(Map<String, dynamic> map) {
    return GeoDistanceRequest(
      origin: LatLng.fromJson(map['origin'] as Map<String, dynamic>),
      distance: LatLng.fromJson(map['distance'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoDistanceRequest.fromJson(String source) =>
      GeoDistanceRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GeoDistanceRequest(origin: $origin, distance: $distance)';

  @override
  bool operator ==(covariant GeoDistanceRequest other) {
    if (identical(this, other)) return true;

    return other.origin == origin && other.distance == distance;
  }

  @override
  int get hashCode => origin.hashCode ^ distance.hashCode;
}
