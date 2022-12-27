import 'package:latlong2/latlong.dart';

class GeoDistanceRequest {
  LatLng origin;
  LatLng distance;
  int? id;
  GeoDistanceRequest({required this.origin, required this.distance, this.id});
}
