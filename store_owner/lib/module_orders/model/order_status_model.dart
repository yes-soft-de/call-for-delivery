import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/hive/order_hive_helper.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderStatusModel extends DataModel {
  late int id;
  String? to;
  GeoJson? branchLocation;
  late LatLng toOnMap;
  late String from;
  late DateTime creationTime;
  late String paymentMethod;
  late OrderStatusEnum status;
  late String? ownerPhone;
  late String? captainPhone;
  String? clientPhone;
  String? chatRoomId;
  late String storeName;
  late String? distance;

  /// this field to know if we can remove order
  late bool canRemove;
  late GeoJson? costumerLocation;

  /// to confirm that captain is really in store
  late bool? showConfirm;
  late String? note;
  OrderStatusModel(
      {required this.id,
      required this.to,
      required this.from,
      required this.creationTime,
      required this.paymentMethod,
      required this.status,
      required this.storeName,
      required this.ownerPhone,
      required this.captainPhone,
      required this.clientPhone,
      required this.chatRoomId,
      required this.distance,
      required this.branchLocation,
      required this.canRemove,
      required this.costumerLocation,
      required this.showConfirm,
      required this.note});

  late OrderStatusModel _orders;

  OrderStatusModel.withData(OrderStatusResponse response) {
    var element = response.data;
    bool showConfirmingOrderState =
        OrderHiveHelper().getConfirmOrderState(element?.id ?? -1);

    _orders = OrderStatusModel(
      to: element?.destination,
      clientPhone: element?.recipientPhone,
      from: S.current.unknown,
      creationTime: DateHelper.convert(element?.date?.timestamp),
      paymentMethod: element?.payment ?? 'cash',
      id: element?.id ?? -1,
      branchLocation: GeoJson(),
      canRemove: false,
      captainPhone: null,
      chatRoomId: element?.uuid,
      costumerLocation: GeoJson(),
      distance: null,
      note: element?.note,
      ownerPhone: '',
      showConfirm: showConfirmingOrderState,
      status: StatusHelper.getStatusEnum(element?.state),
      storeName:  S.current.unknown,
    );
  }
}
