import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/response/order/orders_response/destination.dart';

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
