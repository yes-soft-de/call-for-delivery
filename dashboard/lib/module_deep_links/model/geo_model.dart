import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_deep_links/response/geo_distance_x/cost_delivery_order_response/cost_delivery_order.dart';

class GeoDistanceModel extends DataModel {
  String? distance;
  CostDeliveryOrder? costDeliveryOrder;
  GeoDistanceModel({this.distance, this.costDeliveryOrder});
}
