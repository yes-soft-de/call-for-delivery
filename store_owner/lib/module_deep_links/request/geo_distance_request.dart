// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:latlong2/latlong.dart';

class GeoDistanceRequest {
  LatLng? origin;
  LatLng? distance;
  String? link;

  GeoDistanceRequest({
    this.origin,
    this.distance,
    this.link,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (origin != null) 'originLat': origin!.latitude,
      if (origin != null) 'originLng': origin!.longitude,
      if (link != null) 'mapUrlLink': link,
    };
  }

  GeoDistanceRequest copyWith({
    LatLng? origin,
    LatLng? distance,
    String? link,
  }) {
    return GeoDistanceRequest(
      origin: origin ?? this.origin,
      distance: distance ?? this.distance,
      link: link ?? this.link,
    );
  }

  @override
  bool operator ==(covariant GeoDistanceRequest other) {
    if (identical(this, other)) return true;

    return other.origin == origin &&
        other.distance == distance &&
        other.link == link;
  }

  @override
  int get hashCode => origin.hashCode ^ distance.hashCode ^ link.hashCode;
}
