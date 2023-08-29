import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/response/external_order_response/order_pending_response.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/response/orders_response/datum.dart';
import 'package:c4d/module_orders/response/orders_response/sub_order_list/sub_order.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';

class ExternalOrder extends DataModel {
  List<OrderModel> deliveredOrders = [];
  List<OrderModel> pendingOrders = [];
  List<OrderModel> notDeliveredOrders = [];
  late int totalOrderCount;
  late int pendingOrdersCount;
  late int deliveredOrdersCount;
  late int notDeliveredOrdersCount;
  ExternalOrder(
      {required this.deliveredOrders,
      required this.notDeliveredOrders,
      required this.pendingOrders,
      required this.totalOrderCount,
      required this.pendingOrdersCount,
      required this.deliveredOrdersCount,
      required this.notDeliveredOrdersCount});
  late ExternalOrder _data;
  ExternalOrder.withData(ExternalOrderResponse response) {
    var element = response.data;
    _data = ExternalOrder(
        deliveredOrders: _getOrders(element?.deliveredOrders ?? []),
        notDeliveredOrders: _getOrders(element?.notDeliveredOrders ?? []),
        pendingOrders: _getOrders(element?.pendingOrders ?? []),
        totalOrderCount: element?.totalOrderCount?.toInt() ?? 0,
        deliveredOrdersCount: element?.deliveredOrdersCount?.toInt() ?? 0,
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
        externalCompanyName:
            (element.externalDeliveryOrder?.isNotEmpty ?? false)
                ? element.externalDeliveryOrder?.first.companyName
                : null,
        orderIdInExternalCompany:
            (element.externalDeliveryOrder?.isNotEmpty ?? false)
                ? element.externalDeliveryOrder?.first.externalOrderId
                : null,
        captainName: element.captainName ?? 'Unknown',
        storeId: element.storeOrderDetailsId ?? 0,
        branchName: element.branchName ?? '',
        state: StatusHelper.getStatusEnum(element.state),
        orderCost: element.orderCost ?? 0,
        note: element.note ?? '',
        deliveryDate: delivery,
        createdDate: create,
        captainProfileId: element.captainProfileId,
        created: DateHelper.convert(element.createdAt?.timestamp),
        delivery: DateHelper.convert(element.deliveryDate?.timestamp),
        id: element.id ?? -1,
        storeName: element.storeOwnerName ?? S.current.unknown,
        orderIsMain: element.orderIsMain ?? false,
        subOrders: _getPendingOrders(element.subOrders ?? []),
        kilometer: 0,
        storeBranchToClientDistance: 0,
      ));
    });

    return ordersModels;
  }

  List<OrderModel> _getPendingOrders(List<SubOrder> suborder) {
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
        externalCompanyName: null,
        branchName: element.branchName ?? S.current.unknown,
        createdDate: create,
        deliveryDate: delivery,
        id: element.id ?? -1,
        note: element.note ?? '',
        orderCost: element.orderCost ?? 0,
        orderIsMain: false,
        state: StatusHelper.getStatusEnum(element.state),
        storeName: element.storeOwnerName,
        subOrders: [],
        kilometer: 0,
        storeBranchToClientDistance: 0,
      ));
    });
    return orders;
  }

  ExternalOrder get data => _data;
}
