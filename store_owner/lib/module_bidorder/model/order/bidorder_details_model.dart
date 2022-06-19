import 'package:c4d/module_bidorder/response/bidorder_details/bidorder_details_response.dart';
import 'package:c4d/module_orders/response/order_logs_response/data.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';

class BidOrderDetailsModel extends DataModel {
  late int id;
  late String branchName;
  late String categoryName;
//  late String customerPhone;
//  late LatLng? destinationCoordinate;
//  late String? destinationLink;
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
  String? branchPhone;
//  late bool? isCaptainArrived;
//  late num? kilometer;
//  late num? paidToProvider;

  /// this field to know if we can remove order
//  late bool canRemove;
//  String? distance;
  num? captainOrderCost;
  String? attention;
  late OrderTimeLine? orderLogs;
  BidOrderDetailsModel({
    required this.id,
    required this.branchName,
    required this.categoryName,
//      required this.customerName,
//      required this.customerPhone,
//      required this.destinationCoordinate,
//      required this.destinationLink,
    required this.deliveryDateString,
    required this.createdDate,
    required this.note,
    required this.orderCost,
    required this.payment,
    required this.state,
    required this.roomID,
//      required this.canRemove,
    required this.deliveryDate,
    required this.image,
    required this.captainID,
//      required this.distance,
//      required this.isCaptainArrived,
    required this.branchPhone,
    required this.attention,
    required this.captainOrderCost,
    required this.orderLogs,
//      required this.kilometer,
//      required this.paidToProvider
  });

  late BidOrderDetailsModel _orders;

  BidOrderDetailsModel.withData(BidOrderDetailsResponse response) {
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
    _orders = BidOrderDetailsModel(
      image: element?.image?.image,
//        isCaptainArrived: element?.isCaptainArrived,
      branchPhone: element?.branchPhone,
      branchName: element?.branchName ?? S.current.unknown,
      createdDate: create,
      categoryName: element?.supplierCategoryName ?? S.current.unknown,
//        customerPhone: element?.recipientPhone ?? '',
      deliveryDateString: delivery,
      deliveryDate: DateHelper.convert(element?.deliveryDate?.timestamp),
//        destinationCoordinate: element?.destination?.lat != null &&
//                element?.destination?.lon != null
//            ? LatLng(
//                element?.destination?.lat ?? 0, element?.destination?.lon ?? 0)
//            : null,
//        destinationLink: element?.destination?.link,
      note: element?.note ?? '',
      orderCost: element?.orderCost ?? 0,
      payment: element?.payment ?? 'cash',
      roomID: element?.roomId,
      state: StatusHelper.getStatusEnum(element?.state),
      id: element?.id ?? -1,
      captainID: int.tryParse(element?.captainId ?? '-1') ?? -1,
//        distance: null,
      attention: element?.attention,
      captainOrderCost: element?.captainOrderCost,
      orderLogs: _getOrderLogs(element?.orderLogs),
//        kilometer: element?.kilometer,
//        paidToProvider: element?.paidToProvider
    );
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

  BidOrderDetailsModel get data => _orders;
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
