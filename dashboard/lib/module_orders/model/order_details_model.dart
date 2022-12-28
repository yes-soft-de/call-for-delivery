import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/response/order_details_response/captain.dart';
import 'package:c4d/module_orders/response/order_logs_response/data.dart';
import 'package:c4d/module_orders/response/orders_response/sub_order_list/sub_order.dart';
import 'package:c4d/module_upload/model/pdf_model.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';

class OrderDetailsModel extends DataModel {
  late int id;
  late String branchName;
  late String customerName;
  late String customerPhone;
  late LatLng? destinationCoordinate;
  late String? destinationLink;
  late String deliveryDateString;
  late DateTime deliveryDate;
  late DateTime createdAt;
  late String createdDate;
  late String note;
  late num orderCost;
  late String payment;
  late OrderStatusEnum state;
  late String? roomID;
  String? image;
  int? captainID;
  String? branchPhone;
  late bool? isCaptainArrived;
  late num? kilometer;
  late num? paidToProvider;
  int? branchId;
  String? imagePath;
  late bool orderIsMain;
  List<OrderModel> subOrders = [];

  /// this field to know if we can remove order
  bool canRemove = false;
  String? distance;
  num? captainOrderCost;
  String? attention;
  late OrderTimeLine? orderLogs;
  late String? captainName;
  late String storeName;
  late int storeID;
  String? noteCaptainOrderCost;
  PdfModel? pdf;
  Captain? captain;
  String? storeBranchToClientDistance;
  String? branchID;
  int? primaryOrderId;
  OrderDetailsModel({
    required this.id,
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
    required this.canRemove,
    required this.deliveryDate,
    required this.image,
    required this.captainID,
    required this.distance,
    required this.isCaptainArrived,
    required this.branchPhone,
    required this.attention,
    required this.captainOrderCost,
    required this.orderLogs,
    required this.kilometer,
    required this.paidToProvider,
    required this.branchId,
    required this.imagePath,
    required this.orderIsMain,
    required this.captainName,
    required this.storeName,
    required this.storeID,
    required this.noteCaptainOrderCost,
    required this.pdf,
    required this.captain,
    required this.storeBranchToClientDistance,
    required this.branchID,
    required this.createdAt,
    required this.subOrders,
    required this.primaryOrderId,
  });

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
    //
    _orders = OrderDetailsModel(
      image: element?.image?.image,
      canRemove: false,
      isCaptainArrived: element?.isCaptainArrived,
      branchPhone: element?.branchPhone,
      branchName: element?.branchName ?? S.current.unknown,
      createdDate: create,
      customerName: element?.recipientName ?? S.current.unknown,
      customerPhone: element?.recipientPhone ?? '',
      deliveryDateString: delivery,
      deliveryDate: DateHelper.convert(element?.deliveryDate?.timestamp),
      destinationCoordinate:
          element?.destination?.lat != null && element?.destination?.lon != null
              ? LatLng(element?.destination?.lat?.toDouble() ?? 0,
                  element?.destination?.lon?.toDouble() ?? 0)
              : null,
      destinationLink: element?.destination?.link,
      note: element?.note ?? '',
      orderCost: element?.orderCost ?? 0,
      payment: element?.payment ?? 'cash',
      roomID: element?.roomId,
      state: StatusHelper.getStatusEnum(element?.state),
      id: element?.id ?? -1,
      captainID: int.tryParse(element?.captainId ?? '-1') ?? -1,
      distance: null,
      attention: element?.attention,
      captainOrderCost: element?.captainOrderCost,
      orderLogs: _getOrderLogs(element?.orderLogs),
      kilometer: element?.kilometer,
      paidToProvider: element?.paidToProvider,
      branchId: element?.storeOwnerBranchId,
      imagePath: element?.image?.imageUrl,
      orderIsMain: element?.orderIsMain ?? false,
      captainName: element?.captainName,
      storeName: element?.storeName ?? S.current.unknown,
      storeID: element?.storeId ?? -1,
      noteCaptainOrderCost: element?.noteCaptainOrderCost,
      pdf: element?.pdf != null
          ? PdfModel(
              pdfOnServerPath: element?.pdf?.fileUrl,
              pdfPreview: element?.pdf?.file,
              pdfBaseUrl: element?.pdf?.baseUrl)
          : null,
      captain: element?.captain,
      storeBranchToClientDistance: element?.storeBranchToClientDistance,
      branchID: element?.storeOwnerBranchId?.toString(),
      createdAt: DateHelper.convert(element?.createdAt?.timestamp),
      subOrders: _getOrders(element?.subOrders ?? []),
      primaryOrderId: element?.primaryOrderId,
    );
    _orders.canRemove = _canRemove(_orders.state);
    _orders.distance = _distance(_orders, location);
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

  OrderTimeLine? _getOrderLogs(OrderLogsResponse? orderLogs) {
    if (orderLogs == null) {
      return null;
    }
    List<Step> steps = [];
    orderLogs.orderLogs?.logs?.forEach((element) {
      // step date
      var stepDate = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.yMd()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      steps.add(Step(
          state: StatusHelper.getStatusEnum(element.orderState),
          date: stepDate,
          isCaptainArrived: element.isCaptainArrived ?? false));
    });
    steps = steps.reversed.toList();
    OrderTimeLine orderTimeLine = OrderTimeLine(
        steps: steps,
        completionTime: orderLogs.orderLogs?.orderState?.completionTime,
        currentState: StatusHelper.getStatusEnum(
            orderLogs.orderLogs?.orderState?.currentStage));
    return orderTimeLine;
  }

  bool _canRemove(OrderStatusEnum state) {
    if (state == OrderStatusEnum.WAITING) {
      return true;
    }
    return canRemove;
  }

  String? _distance(OrderDetailsModel orderInfo, LatLng? location) {
    String? distance;
    if (orderInfo.destinationCoordinate != null) {
      // var value = DeepLinksService.getInitDistance(
      //     LatLng(orderInfo.destinationCoordinate?.latitude ?? 0,
      //         orderInfo.destinationCoordinate?.longitude ?? 0),
      //     location);
      var value = null;
      if (value == null) return null;
      distance = value.toStringAsFixed(1);
      distance = S.current.distance + ' $distance ' + S.current.km;
      return distance;
    }
    return null;
  }

  OrderDetailsModel get data => _orders;
}

class OrderTimeLine {
  String? completionTime;
  OrderStatusEnum currentState;
  List<Step> steps;
  OrderTimeLine(
      {this.completionTime, required this.steps, required this.currentState});
}

class Step {
  OrderStatusEnum state;
  String date;
  bool isCaptainArrived;
  Step(
      {required this.state,
      required this.date,
      required this.isCaptainArrived});
}
