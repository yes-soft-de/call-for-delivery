import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
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
  late String branchName;
  LatLng? location;
  late String distance;
  OrderModel(
      {required this.branchName,
      required this.state,
      required this.orderCost,
      required this.note,
      required this.deliveryDate,
      required this.createdDate,
      required this.id,
      required this.location,
      required this.distance});
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
          distance: S.current.unknown));
    });
    _orders = _sortOrder(_orders);
  }
  List<OrderModel> _sortOrder(List<OrderModel> orders) {
    if (orders.isEmpty) {
      return [];
    } else {
      List<OrderModel> sorted = orders;
      DeepLinksService.defaultLocation().then((myPos) {
        if (myPos != null) {
          Distance distance = const Distance();
          sorted.sort((a, b) {
            try {
              var pos1 = a.location as LatLng;
              var pos2 = b.location as LatLng;
              var straightDistance1 =
                  distance.as(LengthUnit.Kilometer, pos1, myPos);
              var straightDistance2 =
                  distance.as(LengthUnit.Kilometer, pos2, myPos);
              a.distance = straightDistance1.toStringAsFixed(1);
              b.distance = straightDistance2.toStringAsFixed(1);
              return straightDistance1.compareTo(straightDistance2);
            } catch (e) {
              return 1;
            }
          });
          return;
        } else {
          return;
        }
      });
      return sorted;
    }
  }

  List<OrderModel> get data => _orders;
}
