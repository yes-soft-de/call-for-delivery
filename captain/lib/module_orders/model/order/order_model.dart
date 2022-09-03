import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/module_orders/response/sub_order_list/sub_order.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class OrderModel extends DataModel {
  late int id;
  late OrderStatusEnum state;
  late num orderCost;
  late String? note;
  late String deliveryDate;
  late String createdDate;
  late String branchName;
  LatLng? location;
  LatLng? destination;
  String? destinationLink;
  late num distance;
  late String paymentMethod;
  late List<OrderModel> subOrders;
  late bool orderIsMain;
  late int isHide;
  late num? storeBranchToClientDistance;
  late String storeName;
  OrderModel(
      {required this.branchName,
      required this.state,
      required this.orderCost,
      required this.note,
      required this.deliveryDate,
      required this.createdDate,
      required this.id,
      required this.location,
      required this.distance,
      required this.paymentMethod,
      required this.subOrders,
      required this.orderIsMain,
      required this.isHide,
      required this.storeBranchToClientDistance,
      required this.storeName,
      this.destination,
      this.destinationLink});
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
          branchName: element.branchName ?? S.current.unknown,
          createdDate: create,
          deliveryDate: delivery,
          id: element.id ?? -1,
          note: element.note ?? '',
          orderCost: element.orderCost ?? 0,
          state: StatusHelper.getStatusEnum(element.state),
          location: element.location != null
              ? LatLng(element.location?.lat, element.location?.lon)
              : null,
          distance: 0,
          paymentMethod: element.payment ?? 'cash',
          isHide: element.isHide ?? -1,
          orderIsMain: element.orderIsMain ?? false,
          subOrders: _getOrders(element.suborder ?? []),
          storeBranchToClientDistance: element.storeBranchToClientDistance,
          storeName: element.storeOwnerName ?? S.current.unknown,
          destinationLink: element.destination?.link,
          destination: element.destination?.lat != null
              ? LatLng(
                  element.destination?.lat ?? 0, element.destination?.lon ?? 0)
              : null));
    });
  }
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
          branchName: element.branchName ?? S.current.unknown,
          createdDate: create,
          deliveryDate: delivery,
          id: element.id ?? -1,
          note: element.note,
          orderCost: element.orderCost ?? 0,
          orderIsMain: false,
          subOrders: [],
          state: StatusHelper.getStatusEnum(element.state),
          isHide: -1,
          distance: 0,
          location: LatLng(element.location?.latitude?.toDouble() ?? 0,
              element.location?.longitude?.toDouble() ?? 0),
          paymentMethod: element.payment ?? 'cash',
          storeBranchToClientDistance: element.storeBranchToClientDistance,
          storeName: element.storeOwnerName ?? S.current.unknown));
    });
    return orders;
  }

  List<OrderModel> get data => _orders;
}
