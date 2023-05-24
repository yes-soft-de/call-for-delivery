// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/request/order_conflict_distance_request/order_conflict_distance_request.dart';

class ConflictDistanceOrder extends DataModel {
  late int id;
  late int orderId;
  late int conflictResolvedBy;
  late int conflictResolvedByUserType;
  late int resolveType;
  late int captainProfileId;
  late int storeOwnerProfileId;
  late bool isResolved;
  late double oldDistance;
  late double newDistance;
  late Coordinates oldDestination;
  late Coordinates newDestination;
  late String? adminNote;
  late String conflictNote;
  late String proposedDestinationOrDistance;
  late String captainName;
  late String storeOwnerName;

  ConflictDistanceOrder({
    required this.id,
    required this.orderId,
    this.adminNote,
    required this.conflictResolvedBy,
    required this.conflictResolvedByUserType,
    required this.isResolved,
    required this.conflictNote,
    required this.oldDistance,
    required this.newDistance,
    required this.oldDestination,
    required this.newDestination,
    required this.proposedDestinationOrDistance,
    required this.resolveType,
    required this.captainName,
    required this.captainProfileId,
    required this.storeOwnerName,
    required this.storeOwnerProfileId,
  });

  ConflictDistanceOrder.withData(OrderConflictDistanceRequest request) {
    var data = request.data;

    data?.forEach(
      (element) {
        _orders.add(ConflictDistanceOrder(
          id: element.id ?? -1,
          orderId: element.orderId ?? -1,
          adminNote: element.adminNote,
          captainName: element.captainName ?? S.current.unknown,
          captainProfileId: element.captainProfileId ?? -1,
          conflictNote: element.conflictNote ?? '',
          conflictResolvedBy: element.conflictResolvedBy ?? -1,
          conflictResolvedByUserType: element.conflictResolvedByUserType ?? -1,
          isResolved: element.isResolved ?? false,
          newDestination: Coordinates(
            lat: element.newDestination?.lat ?? -1,
            lon: element.newDestination?.lon ?? -1,
          ),
          newDistance: element.newDistance ?? -1,
          oldDestination: Coordinates(
            lat: element.oldDestination?.lat ?? -1,
            lon: element.oldDestination?.lon ?? -1,
          ),
          oldDistance: element.oldDistance ?? -1,
          proposedDestinationOrDistance:
              element.proposedDestinationOrDistance ?? '',
          resolveType: element.resolveType ?? -1,
          storeOwnerName: element.storeOwnerName ?? S.current.unknown,
          storeOwnerProfileId: element.storeOwnerProfileId ?? -1,
        ));
      },
    );
  }

  List<ConflictDistanceOrder> _orders = [];
  List<ConflictDistanceOrder> get data => _orders;
}

class Coordinates {
  double lat;
  double lon;

  Coordinates({
    required this.lat,
    required this.lon,
  });

  String? asString() {
    if (lat == -1 || lon == -1) return null;

    return '$lat,$lon';
  }
}
