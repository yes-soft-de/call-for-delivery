import 'package:c4d/module_orders/response/orders_response/destination.dart';

class UpdateDistanceRequest {
  num? storeBranchToClientDistance;
  int id;
  Destination destination;
  UpdateDistanceRequest(
      {required this.id,
      required this.storeBranchToClientDistance,
      required this.destination});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeBranchToClientDistance'] = storeBranchToClientDistance;
    data['id'] = id;
    data['destination'] = destination;
    return data;
  }
}
