// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_deep_links/response/geo_distance_x/cost_delivery_order_response/cost_delivery_order.dart';

class GeoDistanceModel extends DataModel {
  String? distance;
  GeoDestination? geoDestination;
  CostDeliveryOrder? costDeliveryOrder;

  GeoDistanceModel({
    this.distance,
    this.costDeliveryOrder,
    this.geoDestination,
  });
}

class GeoDestination {
  double lat;
  double lon;

  GeoDestination({
    required this.lat,
    required this.lon,
  });
}
