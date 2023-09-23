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
}
