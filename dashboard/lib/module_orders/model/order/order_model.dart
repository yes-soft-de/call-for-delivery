import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
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
  late String? storeName;
  late bool? orderIsMain;
  late LatLng? branchLocation;
  late String? destinationLink;
  int? isCashPaymentConfirmedByStore;
  int? paidToProvider;
  String? captainName;
  int? storeId;
  OrderModel(
      {required this.branchName,
      required this.state,
      required this.orderCost,
      required this.note,
      required this.deliveryDate,
      required this.createdDate,
      required this.id,
      required this.storeName,
      required this.orderIsMain,
      this.destinationLink,
      this.branchLocation,
      this.isCashPaymentConfirmedByStore,
      this.paidToProvider,
      this.captainName,
      this.storeId});
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
          storeId: element.storeOrderDetailsId,
          captainName: element.captainName,
          branchName: element.branchName ?? S.current.unknown,
          createdDate: create,
          deliveryDate: delivery,
          id: element.id ?? -1,
          note: element.note ?? '',
          orderCost: element.orderCost ?? 0,
          state: StatusHelper.getStatusEnum(element.state),
          storeName: element.storeOwnerName,
          orderIsMain: element.orderIsMain,
          paidToProvider: element.paidToProvider,
          isCashPaymentConfirmedByStore: element.isCashPaymentConfirmedByStore,
          branchLocation:
              LatLng(element.location?.lat ?? 0, element.location?.lon ?? 0),
          destinationLink: element.destination?.link));
    });
  }
  List<OrderModel> get data => _orders;
}
