import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/module_orders/response/sub_order_list/sub_order.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/finance_status_helper.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class OrderDetailsModel extends DataModel {
  late int id;
  late String branchName;
  late String customerName;
  late String customerPhone;
  late LatLng? destinationCoordinate;
  late String? destinationLink;
  late String deliveryDateString;
  late DateTime deliveryDate;
  late String createdDate;
  late String note;
  late num orderCost;
  late String payment;
  late OrderStatusEnum state;
  late String? roomID;
  String? image;
  int? captainID;
  late String storeName;
  late String storePhone;
  late LatLng? branchCoordinate;
  late String? branchLink;
  String? distance;
  String? branchDistance;
  late bool usedAs;
  String? rating;
  String? branchPhone;
  String? ratingComment;
  late int storeId;
  String? paidToProvider;
  late int? isHide;
  late List<OrderModel> subOrders;
  late bool? orderIsMain;
  late DateTime createDateTime;
  OrderDetailsModel(
      {required this.id,
      required this.branchName,
      required this.customerName,
      required this.customerPhone,
      required this.destinationCoordinate,
      required this.destinationLink,
      required this.deliveryDateString,
      required this.createdDate,
      required this.note,
      required this.orderCost,
      required this.payment,
      required this.state,
      required this.roomID,
      required this.deliveryDate,
      required this.image,
      required this.captainID,
      required this.storeName,
      required this.branchCoordinate,
      required this.storePhone,
      required this.branchLink,
      required this.distance,
      required this.branchDistance,
      required this.usedAs,
      required this.rating,
      required this.branchPhone,
      required this.ratingComment,
      required this.storeId,
      required this.paidToProvider,
      required this.subOrders,
      required this.isHide,
      required this.orderIsMain,
      required this.createDateTime});

  late OrderDetailsModel _orders;

  OrderDetailsModel.withData(OrderDetailsResponse response, LatLng? location) {
    var element = response.data;
    // date converter
    // created At
    var create = DateFormat.jm()
            .format(DateHelper.convert(element?.createdAt?.timestamp)) +
        ' 📅 ' +
        DateFormat.yMMMEd()
            .format(DateHelper.convert(element?.createdAt?.timestamp));
    // delivery date
    var delivery = DateFormat.jm()
            .format(DateHelper.convert(element?.deliveryDate?.timestamp)) +
        ' 📅 ' +
        DateFormat.yMMMEd()
            .format(DateHelper.convert(element?.deliveryDate?.timestamp));
    _orders = OrderDetailsModel(
      rating: element?.rating,
      image: element?.image?.image,
      branchName: element?.branchName ?? S.current.unknown,
      createdDate: create,
      customerName: element?.recipientName ?? S.current.unknown,
      customerPhone: element?.recipientPhone ?? '',
      deliveryDateString: delivery,
      deliveryDate: DateHelper.convert(element?.deliveryDate?.timestamp),
      destinationCoordinate: element?.destination?.lat != null &&
              element?.destination?.lon != null
          ? LatLng(
              element?.destination?.lat ?? 0, element?.destination?.lon ?? 0)
          : null,
      destinationLink: element?.destination?.link,
      note: element?.note ?? '',
      orderCost: element?.orderCost ?? 0,
      payment: element?.payment ?? 'cash',
      roomID: element?.roomId,
      state: StatusHelper.getStatusEnum(element?.state),
      id: element?.id ?? -1,
      captainID: int.tryParse(element?.captainId ?? '-1') ?? -1,
      branchCoordinate:
          element?.location?.lat != null && element?.location?.lon != null
              ? LatLng(element?.location?.lat ?? 0, element?.location?.lon ?? 0)
              : null,
      storeName: element?.storeOwnerName ?? S.current.unknown,
      storePhone: element?.phone ?? '',
      branchLink: element?.location?.link,
      branchDistance: null,
      distance: null,
      usedAs: element?.usedAs == 'not used chat enquire' ? false : true,
      branchPhone: element?.branchPhone,
      ratingComment: element?.ratingComment,
      storeId: element?.storeId ?? -1,
      paidToProvider: FinanceHelper.getStatusString(element?.paidToProvider),
      isHide: element?.isHide,
      subOrders: _getOrders(element?.subOrders ?? []),
      orderIsMain: element?.orderIsMain,
      createDateTime: DateHelper.convert(element?.createdAt?.timestamp),
    );
    _orders.distance = _distance(
        _orders,
        StatusHelper.getOrderStatusIndex(_orders.state) >=
                StatusHelper.getOrderStatusIndex(OrderStatusEnum.IN_STORE)
            ? location
            : branchCoordinate);
    _orders.branchDistance = _branchDistance(_orders, location);
  }
  String? _distance(OrderDetailsModel orderInfo, LatLng? location) {
    String? distance;
    if (orderInfo.destinationCoordinate != null) {
      var value = DeepLinksService.getInitDistance(
          LatLng(orderInfo.destinationCoordinate?.latitude ?? 0,
              orderInfo.destinationCoordinate?.longitude ?? 0),
          location);
      if (value == null) return null;
      distance = value.toStringAsFixed(1);
      distance = S.current.distance + ' $distance ' + S.current.km;
      return distance;
    }
    return null;
  }

  String? _branchDistance(OrderDetailsModel orderInfo, LatLng? location) {
    if (orderInfo.branchCoordinate != null) {
      String? branchDistance;
      var value = DeepLinksService.getInitDistance(
          LatLng(orderInfo.branchCoordinate?.latitude ?? 0,
              orderInfo.branchCoordinate?.longitude ?? 0),
          location);
      if (value == null) return null;
      branchDistance = value.toStringAsFixed(1);
      branchDistance = S.current.distance + ' $branchDistance ' + S.current.km;
      return branchDistance;
    }
    return null;
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

  OrderDetailsModel get data => _orders;
}
