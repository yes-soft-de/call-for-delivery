import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/response/order_pending_response/order_pending_response.dart';
import 'package:c4d/module_orders/response/orders_response/datum.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';

class PendingOrder extends DataModel {
  List<OrderModel> hiddenOrders = [];
  List<OrderModel> pendingOrders = [];
  List<OrderModel> notDeliveredOrders = [];
  PendingOrder(
      {required this.hiddenOrders,
      required this.notDeliveredOrders,
      required this.pendingOrders});
  late PendingOrder _data;
  PendingOrder.withData(OrderPendingResponse response) {
    var element = response.data;
    _data = PendingOrder(
        hiddenOrders: _getOrders(element?.hiddenOrders ?? []),
        notDeliveredOrders: _getOrders(element?.notDeliveredOrders ?? []),
        pendingOrders: _getOrders(element?.pendingOrders ?? []));
  }
  List<OrderModel> _getOrders(List<DatumOrder> orders) {
    List<OrderModel> ordersModels = [];
    orders.forEach((element) {
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
      ordersModels.add(OrderModel(
          branchName: element.branchName ?? '',
          state: StatusHelper.getStatusEnum(element.state),
          orderCost: element.orderCost ?? 0,
          note: element.note ?? '',
          deliveryDate: delivery,
          createdDate: create,
          id: element.id ?? -1));
    });

    return ordersModels;
  }

  PendingOrder get data => _data;
}
