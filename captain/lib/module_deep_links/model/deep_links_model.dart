import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:latlong2/latlong.dart';

class DeepLinksModel {
  Uri link;
  LatLng location;
  DeepLinksModel({
    required this.link,
    required this.location,
  });
}
