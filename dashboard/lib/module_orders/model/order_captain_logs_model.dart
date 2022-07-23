import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/response/order_captain_logs_response/order_captain_logs_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';

class OrderCaptainLogsModel extends DataModel {
  late List<OrderModel> orders;
  late int countOrders;
  late num? cashOrder;
  OrderCaptainLogsModel(
      {required this.countOrders,
      required this.orders,
      required this.cashOrder});
  OrderCaptainLogsModel? _orders;
  OrderCaptainLogsModel.withData(OrderCaptainLogsResponse response) {
    var data = response.data;
    var count_Order = data?.countOrders ?? 0;
    List<OrderModel> orders = [];
    data?.orders?.forEach((element) {
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
      orders.add(OrderModel(
          branchName: element.branchName ?? S.current.unknown,
          createdDate: create,
          deliveryDate: delivery,
          id: element.id ?? -1,
          note: element.note ?? '',
          orderCost: element.orderCost ?? 0,
          state: StatusHelper.getStatusEnum(element.state),
          storeName: element.storeOwnerName));
    });
    _orders = OrderCaptainLogsModel(
        orders: orders, countOrders: count_Order, cashOrder: data?.cashOrder);
  }
  OrderCaptainLogsModel get data =>
      _orders ??
      OrderCaptainLogsModel(countOrders: 0, orders: [], cashOrder: null);
}
