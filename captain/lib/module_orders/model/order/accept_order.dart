import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:latlong2/latlong.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/response/orders/accept_order_response.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';

class AcceptOrderModel extends DataModel {
  late int id;
  late String orderNumber;
  late DateTime deliveryDate;
  String? details;
  int? storeId;
  String? storeName;
  LatLng? _currentLocation;
  late int orderType;
  late OrderStatusEnum state;
  String? error;
  bool? empty;
  AcceptOrderModel(
      {required this.id,
      this.storeName,
      required this.deliveryDate,
      required this.orderNumber,
      this.storeId,
      this.details,
      required this.orderType,
      required this.state,
      this.empty,
      this.error});

  final List<AcceptOrderModel> _models = [];

  AcceptOrderModel.withData(AcceptOrderResponse response,
      [LatLng? initLocation]) {
    List<AcceptedOrder> data = response.data ?? [];

    for (var element in data) {
      int timestamp = element.deliveryDate?.timestamp ??
          DateTime.now().millisecondsSinceEpoch;
      var creationDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      _models.add(AcceptOrderModel(
        id: element.id ?? -1,
        storeName: element.storeOwnerName ?? S.current.store,
        deliveryDate: creationDate,
        orderNumber: element.orderNumber.toString(),
        orderType: element.orderType ?? 0,
        state: StatusHelper.getStatusEnum(element.state),
      ));
    }
  }
  bool get hasData => _models.isNotEmpty;

  List<AcceptOrderModel> get data => _models;

  LatLng? get currentLocation => _currentLocation;
}
