import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/module_orders/response/orders_response/sub_order_list/sub_order.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';

class OrderModel extends DataModel {
  late int id;
  late OrderStatusEnum state;
  late num orderCost;
  late String? note;
  late String deliveryDate;
  late String createdDate;
  late String branchName;
  late int orderType;
  late bool orderIsMain;
  late List<OrderModel> orders;
  late num isHide;
  OrderModel(
      {required this.branchName,
      required this.state,
      required this.orderCost,
      required this.note,
      required this.deliveryDate,
      required this.createdDate,
      required this.id,
      required this.orderType,
      required this.orderIsMain,
      required this.orders,
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
      if (element.isHide?.toInt() != 1) {
        _orders.add(OrderModel(
            branchName: element.branchName ?? S.current.unknown,
            createdDate: create,
            deliveryDate: delivery,
            id: element.id ?? -1,
            note: element.note ?? '',
            orderCost: element.orderCost ?? 0,
            state: StatusHelper.getStatusEnum(element.state),
            orderType: element.orderType ?? 1,
            orderIsMain: element.orderIsMain ?? false,
            orders: _getOrders(element.subOrders ?? []),
            isHide: element.isHide ?? -1));
      }
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
          branchName: element.branchName ?? S.current.unknown,
          createdDate: create,
          deliveryDate: delivery,
          id: element.id ?? -1,
          note: element.note,
          orderCost: element.orderCost ?? 0,
          orderIsMain: false,
          orders: [],
          orderType: 1,
          state: StatusHelper.getStatusEnum(element.state),
          isHide: -1));
    });
    return orders;
  }
}
