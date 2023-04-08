import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/module_orders/response/orders_response/sub_order_list/sub_order.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class OrderModel extends DataModel {
  late int id;
  late OrderStatusEnum state;
  late num orderCost;
  late String note;
  late String deliveryDate;
  late String createdDate;
  late DateTime? created;
  late DateTime? delivery;
  late String branchName;
  late String? storeName;
  late bool orderIsMain;
  late LatLng? branchLocation;
  late String? destinationLink;
  String? storeBranchToClientDistanceAdditionExplanation;
  int? isCashPaymentConfirmedByStore;
  int? paidToProvider;
  String? captainName;
  int? captainProfileId;
  int? storeId;
  String? branchID;
  List<OrderModel> subOrders = [];
  late num kilometer;
  late num storeBranchToClientDistance;
  int? packageType;
  int? costType;
  OrderModel({
    required this.branchName,
    required this.state,
    required this.orderCost,
    required this.note,
    required this.deliveryDate,
    required this.createdDate,
    required this.id,
    required this.storeName,
    required this.orderIsMain,
    this.destinationLink,
    this.branchLocation,
    this.isCashPaymentConfirmedByStore,
    this.paidToProvider,
    this.captainName,
    this.captainProfileId,
    this.storeId,
    this.branchID,
    this.created,
    this.delivery,
    required this.subOrders,
    required this.kilometer,
    required this.storeBranchToClientDistance,
    this.storeBranchToClientDistanceAdditionExplanation,
    this.packageType,
    this.costType,
  });
  List<OrderModel> _orders = [];
  OrderModel.withData(OrdersResponse response) {
    var data = response.data;
    data?.forEach((element) {
      // date formatter
      // created At
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      // delivery date
      var delivery = DateFormat.jm()
              .format(DateHelper.convert(element.deliveryDate?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.deliveryDate?.timestamp));
      //
      _orders.add(OrderModel(
        captainName: element.captainName,
        captainProfileId: element.captainProfileId,
        branchName: element.branchName ?? S.current.unknown,
        createdDate: create,
        deliveryDate: delivery,
        id: element.id ?? -1,
        note: element.note ?? '',
        orderCost: element.orderCost ?? 0,
        state: StatusHelper.getStatusEnum(element.state),
        storeName: element.storeOwnerName,
        orderIsMain: element.orderIsMain ?? false,
        paidToProvider: element.paidToProvider,
        isCashPaymentConfirmedByStore: element.isCashPaymentConfirmedByStore,
        branchID: element.storeOwnerBranchId?.toString(),
        branchLocation: LatLng(element.location?.lat?.toDouble() ?? 0,
            element.location?.lon?.toDouble() ?? 0),
        destinationLink: element.destination?.link,
        created: DateHelper.convert(element.createdAt?.timestamp),
        delivery: DateHelper.convert(element.deliveryDate?.timestamp),
        subOrders: _getOrders(element.subOrders ?? []),
        kilometer: element.kilometer ?? 0,
        storeBranchToClientDistance: element.storeBranchToClientDistance ?? 0,
        storeBranchToClientDistanceAdditionExplanation:
            element.storeBranchToClientDistanceAdditionExplanation,
        packageType: element.packageType,
        costType: element.costType,
      ));
    });
  }
  List<OrderModel> get data => _orders;
  List<OrderModel> _getOrders(List<SubOrder> suborder) {
    List<OrderModel> orders = [];
    suborder.forEach((element) {
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      var delivery = DateFormat.jm()
              .format(DateHelper.convert(element.deliveryDate?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.deliveryDate?.timestamp));
      orders.add(OrderModel(
        captainProfileId: element.captainProfileId,
        branchName: element.branchName ?? S.current.unknown,
        createdDate: create,
        deliveryDate: delivery,
        id: element.id ?? -1,
        note: element.note ?? '',
        orderCost: element.orderCost ?? 0,
        orderIsMain: false,
        subOrders: [],
        state: StatusHelper.getStatusEnum(element.state),
        storeName: element.storeOwnerName,
        kilometer: 0,
        storeBranchToClientDistance: 0,
      ));
    });
    return orders;
  }
}
