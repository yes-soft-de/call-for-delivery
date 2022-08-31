import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/response/order_without_distance_response/order_captain_logs_response.dart';
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
          branchName: element.branchName ?? S.current.unknown,
          createdDate: create,
          deliveryDate: delivery,
          storeId: element.storeOrderDetailsId,
          id: element.id ?? -1,
          note: element.note ?? '',
          orderCost: element.orderCost ?? 0,
          state: StatusHelper.getStatusEnum(element.state),
          storeName: element.storeOwnerName,
          orderIsMain: element.orderIsMain,
          branchLocation: LatLng(element.location?.lat, element.location?.lon),
          destinationLink: element.destination?.link));
    });
    _orders = OrdersWithoutDistanceModel(orders: orders);
  }
  OrdersWithoutDistanceModel get data =>
      _orders ?? OrdersWithoutDistanceModel(orders: []);
}
