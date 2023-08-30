import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_captain/response/captain_activity_response/captain_activity_details_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../consts/order_status.dart';
import '../../utils/helpers/order_status_helper.dart';

class CaptainActivityDetailsModel extends DataModel {
  late int id;
  late OrderStatusEnum state;
  late String payment;
  late int orderCost;
  late int orderType;
  late String note;
  late int storeOrderDetailsId;
  late String detail;
  late num captainOrderCost;
  late String deliveryDate;
  late String createdDate;
  late DateTime? created;
  late DateTime? delivery;
  late String? branchName;
  late LatLng? branchLocation;
  late LatLng? destination;
  late String? recipientName;
  late num? recipientPhone;
  late bool? orderIsMain;
  late num? profit;

  CaptainActivityDetailsModel({
    required this.id,
    required this.state,
    required this.payment,
    required this.orderCost,
    required this.orderType,
    required this.note,
    required this.storeOrderDetailsId,
    required this.detail,
    required this.captainOrderCost,
    required this.deliveryDate,
    required this.createdDate,
    this.created,
    this.delivery,
    this.branchName,
    this.branchLocation,
    this.destination,
    this.recipientName,
    this.recipientPhone,
    this.orderIsMain,
    this.profit,
  });

  List<CaptainActivityDetailsModel> _ordersDetails = [];

  CaptainActivityDetailsModel.withData(
      CaptainActivityDetailsResponse response) {
    var data = response.data;
    data?.forEach((element) {
      //create it
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      //delievery date
      var delivery = DateFormat.jm()
              .format(DateHelper.convert(element.deliveryDate?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.deliveryDate?.timestamp));
      _ordersDetails.add(CaptainActivityDetailsModel(
        id: element.id ?? -1,
        state: StatusHelper.getStatusEnum(element.state),
        payment: element.payment ?? '',
        orderCost: element.orderCost ?? 0,
        orderType: element.orderType ?? 0,
        note: element.note ?? '',
        recipientName: element.recipientName,
        storeOrderDetailsId: element.storeOrderDetailsId ?? 0,
        detail: element.detail ?? '',
        branchName: element.branchName,
        captainOrderCost: element.captainOrderCost ?? 0,
        deliveryDate: delivery,
        createdDate: create,
        profit: element.profit,
      ));
    });
  }
  List<CaptainActivityDetailsModel> get data => _ordersDetails;
}
