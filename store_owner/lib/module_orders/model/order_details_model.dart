import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/hive/order_hive_helper.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class OrderDetailsModel extends DataModel {
  late int id;
  late String branchName;
  late String customerName;
  late String customerPhone;
  late LatLng? destinationCoordinate;
  late String? destinationLink;
  late String deliveryDateString;
  late DateTime deliveryDate;
  late String createdDate;
  late String note;
  late num orderCost;
  late String payment;
  late OrderStatusEnum state;
  late String? roomID;
  String? image;
  int? captainID;
  String? branchPhone;
  late bool isCaptainArrived;

  /// this field to know if we can remove order
  late bool canRemove;
  String? distance;
  OrderDetailsModel(
      {required this.id,
      required this.branchName,
      required this.customerName,
      required this.customerPhone,
      required this.destinationCoordinate,
      required this.destinationLink,
      required this.deliveryDateString,
      required this.createdDate,
      required this.note,
      required this.orderCost,
      required this.payment,
      required this.state,
      required this.roomID,
      required this.canRemove,
      required this.deliveryDate,
      required this.image,
      required this.captainID,
      required this.distance,
      required this.isCaptainArrived,
      required this.branchPhone});

  late OrderDetailsModel _orders;

  OrderDetailsModel.withData(OrderDetailsResponse response) {
    var element = response.data;
    bool showConfirmingOrderState =
        OrderHiveHelper().getConfirmOrderState(element?.id ?? -1);
    // date converter
    // created At
    var create = DateFormat.jm()
            .format(DateHelper.convert(element?.createdAt?.timestamp)) +
        ' 📅 ' +
        DateFormat.yMMMEd()
            .format(DateHelper.convert(element?.createdAt?.timestamp));
    // delivery date
    var delivery = DateFormat.jm()
            .format(DateHelper.convert(element?.deliveryDate?.timestamp)) +
        ' 📅 ' +
        DateFormat.yMMMEd()
            .format(DateHelper.convert(element?.deliveryDate?.timestamp));
    //
    _orders = OrderDetailsModel(
        image: element?.image?.image,
        canRemove:
            _canRemove(DateHelper.convert(element?.createdAt?.timestamp)),
        isCaptainArrived: element?.isCaptainArrived ?? false,
        branchPhone: element?.branchPhone,
        branchName: element?.branchName ?? S.current.unknown,
        createdDate: create,
        customerName: element?.recipientName ?? S.current.unknown,
        customerPhone: element?.recipientPhone ?? '',
        deliveryDateString: delivery,
        deliveryDate: DateHelper.convert(element?.deliveryDate?.timestamp),
        destinationCoordinate: element?.destination?.lat != null &&
                element?.destination?.lon != null
            ? LatLng(
                element?.destination?.lat ?? 0, element?.destination?.lon ?? 0)
            : null,
        destinationLink: element?.destination?.link,
        note: element?.note ?? '',
        orderCost: element?.orderCost ?? 0,
        payment: element?.payment ?? 'cash',
        roomID: element?.roomId,
        state: StatusHelper.getStatusEnum(element?.state),
        id: element?.id ?? -1,
        captainID: int.tryParse(element?.captainId ?? '-1') ?? -1,
        distance: null);
    _distance(_orders).then((value) {
      _orders.distance = value;
    });
  }
  bool _canRemove(DateTime date) {
    bool canRemove = true;
    if (DateTime.now().difference(date).inMinutes < 30) {
      canRemove = false;
    }
    return canRemove;
  }

  Future<String?> _distance(OrderDetailsModel orderInfo) async {
    String? distance;
    if (orderInfo.destinationCoordinate != null) {
      var value = await DeepLinksService.getDistance(LatLng(
          orderInfo.destinationCoordinate?.latitude ?? 0,
          orderInfo.destinationCoordinate?.longitude ?? 0));
      if (value == null) return null;
      distance = value.toStringAsFixed(1);
      distance = S.current.distance + ' $distance ' + S.current.km;
      return distance;
    }
    return null;
  }

  OrderDetailsModel get data => _orders;
}
