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
  late String distance;
  late String paymentMethod;
  late List<OrderModel> subOrders;
  late bool orderIsMain;
  late int isHide;
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
      required this.isHide});
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
          distance: S.current.destinationUnavailable,
          paymentMethod: element.payment ?? 'cash',
          isHide: element.isHide ?? -1,
          orderIsMain: element.orderIsMain ?? false,
          subOrders: _getOrders(element.suborder ?? [])));
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
          distance: S.current.destinationUnavailable,
          location: LatLng(element.location?.latitude?.toDouble() ?? 0,
              element.location?.longitude?.toDouble() ?? 0),
          paymentMethod: ''));
    });
    return orders;
  }

  List<OrderModel> get data => _orders;
}
