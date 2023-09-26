// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  String toJson() => json.encode(toMap());
}
