import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
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
  late int totalOrderCount;
  late int pendingOrdersCount;
  late int hiddenOrdersCount;
  late int notDeliveredOrdersCount;
  PendingOrder(
      {required this.hiddenOrders,
      required this.notDeliveredOrders,
      required this.pendingOrders,
      required this.totalOrderCount,
      required this.pendingOrdersCount,
      required this.hiddenOrdersCount,
      required this.notDeliveredOrdersCount});
  late PendingOrder _data;
  PendingOrder.withData(OrderPendingResponse response) {
    var element = response.data;
    _data = PendingOrder(
        hiddenOrders: _getOrders(element?.hiddenOrders ?? []),
        notDeliveredOrders: _getOrders(element?.notDeliveredOrders ?? []),
        pendingOrders: _getOrders(element?.pendingOrders ?? []),
        totalOrderCount: element?.totalOrderCount?.toInt() ?? 0,
        hiddenOrdersCount: element?.hiddenOrdersCount?.toInt() ?? 0,
        notDeliveredOrdersCount: element?.notDeliveredOrdersCount?.toInt() ?? 0,
        pendingOrdersCount: element?.pendingOrdersCount?.toInt() ?? 0);
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
          id: element.id ?? -1,
          storeName: element.storeOwnerName ?? S.current.unknown));
    });

    return ordersModels;
  }

  PendingOrder get data => _data;
}
