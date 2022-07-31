import 'package:latlong2/latlong.dart';

class GeoDistanceRequest {
  LatLng origin;
  LatLng distance;
  GeoDistanceRequest({
    required this.origin,
    required this.distance,
  });
}
