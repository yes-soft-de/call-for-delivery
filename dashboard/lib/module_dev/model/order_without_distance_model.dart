import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/response/order_without_distance_response/order_captain_logs_response.dart';
import 'package:c4d/module_orders/response/orders_response/sub_order_list/sub_order.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class OrdersWithoutDistanceModel extends DataModel {
  late List<OrderModel> orders;
  OrdersWithoutDistanceModel({
    required this.orders,
  });
  OrdersWithoutDistanceModel? _orders;
  OrdersWithoutDistanceModel.withData(OrdersWithoutDistanceResponse response) {
    var data = response.data;
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
          externalCompanyName: null,
          branchName: element.branchName ?? S.current.unknown,
          createdDate: create,
          deliveryDate: delivery,
          storeId: element.storeOrderDetailsId,
          id: element.id ?? -1,
          note: element.note ?? '',
          orderCost: element.orderCost ?? 0,
          state: StatusHelper.getStatusEnum(element.state),
          storeName: element.storeOwnerName,
          orderIsMain: element.orderIsMain ?? false,
          branchLocation: LatLng(element.location?.lat?.toDouble() ?? 0,
              element.location?.lon?.toDouble() ?? 0),
          destinationLink: element.destination?.link,
          subOrders: _getOrders(element.subOrders ?? []),
          kilometer: 0,
          storeBranchToClientDistance: 0));
    });
    _orders = OrdersWithoutDistanceModel(orders: orders);
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

  OrdersWithoutDistanceModel get data =>
      _orders ?? OrdersWithoutDistanceModel(orders: []);
}
