import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/response/order_logs_response/data.dart';
import 'package:c4d/module_orders/response/orders_response/sub_order_list/sub_order.dart';
import 'package:c4d/module_upload/model/pdf_model.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
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
  late DateTime createDateTime;
  late String createdDate;
  late String? note;
  late num orderCost;
  late String payment;
  late OrderStatusEnum state;
  late String? roomID;
  String? image;
  String? imagePath;
  int? captainID;
  String? branchPhone;
  late bool? isCaptainArrived;
  late num? kilometer;
  late num? paidToProvider;
  late bool orderIsMain;
  late int branchID;
  late String captainRating;
  PdfModel? pdf;
  String? storeBranchToClientDistance;

  /// this field to know if we can remove order
  late bool canRemove;
  String? distance;
  num? captainOrderCost;
  String? attention;
  late OrderTimeLine? orderLogs;
  late List<OrderModel> subOrders;
  late String? captainName;
  late String? captainPhone;
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
      required this.orderIsMain,
      required this.subOrders,
      required this.createDateTime,
      required this.imagePath,
      required this.branchID,
      required this.captainName,
      required this.captainPhone,
      required this.captainRating,
      this.pdf,
      this.storeBranchToClientDistance});

  late OrderDetailsModel _orders;

  OrderDetailsModel.withData(OrderDetailsResponse response) {
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
      canRemove: _canRemove(DateHelper.convert(element?.createdAt?.timestamp)),
      isCaptainArrived: element?.isCaptainArrived,
      branchPhone: element?.branchPhone,
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
      note: element?.note,
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
      orderIsMain: element?.orderIsMain ?? false,
      subOrders: _getOrders(element?.subOrders ?? []),
      createDateTime: DateHelper.convert(element?.createdAt?.timestamp),
      imagePath: element?.image?.imageUrl,
      branchID: element?.storeOwnerBranchId ?? -1,
      captainName: element?.captainName,
      captainPhone: element?.captainDetails?.phone,
      storeBranchToClientDistance: element?.storeBranchToClientDistance,
      pdf: element?.pdf != null
          ? PdfModel(
              pdfOnServerPath: element?.pdf?.fileUrl,
              pdfPreview: element?.pdf?.file,
              pdfBaseUrl: element?.pdf?.baseUrl)
          : null,
      captainRating:
          FixedNumber.getFixedNumber(element?.captainDetails?.rating ?? 0),
    );
  }
  OrderTimeLine? _getOrderLogs(OrderLogsResponse? orderLogs) {
    if (orderLogs == null) {
      return null;
    }
    List<Step> steps = [];
    orderLogs.orderLogs?.logs?.forEach((element) {
      // step date
      var stepDate = DateFormat.jm().format(DateHelper.convert(
            element.createdAt?.timestamp,
          )) +
          ' 📅 ' +
          DateFormat.yMd()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      steps.add(Step(
          state: StatusHelper.getStatusEnum(element.orderState),
          date: stepDate));
    });
    steps = steps.reversed.toList();
    OrderTimeLine orderTimeLine = OrderTimeLine(
        steps: steps,
        completionTime: orderLogs.orderLogs?.orderState?.completionTime,
        currentState: StatusHelper.getStatusEnum(
            orderLogs.orderLogs?.orderState?.currentStage));
    return orderTimeLine;
  }

  bool _canRemove(DateTime date) {
    bool canRemove = true;
    if (DateTime.now().difference(date).inMinutes > 30) {
      canRemove = false;
    }
    return canRemove;
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
          orders: [],
          orderType: 1,
          state: StatusHelper.getStatusEnum(element.state),
          isHide: -1));
    });
    return orders;
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
  Step({
    required this.state,
    required this.date,
  });
}
