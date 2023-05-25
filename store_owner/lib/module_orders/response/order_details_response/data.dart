import 'package:c4d/module_orders/response/order_details_response/captain.dart';
import 'package:c4d/module_orders/response/order_details_response/file_pdf_response.dart';
import 'package:c4d/module_orders/response/order_details_response/images.dart';
import 'package:c4d/module_orders/response/order_logs_response/data.dart';
import 'package:c4d/module_orders/response/orders_response/sub_order_list/sub_order.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';

import 'created_at.dart';
import 'delivery_date.dart';
import 'destination.dart';

class Data {
  int? id;
  String? state;
  String? payment;
  num? orderCost;
  int? orderType;
  String? note;
  DeliveryDate? deliveryDate;
  CreatedAt? createdAt;
  int? storeOrderDetailsId;
  Destination? destination;
  String? recipientName;
  String? recipientPhone;
  String? detail;
  int? storeOwnerBranchId;
  String? branchName;
  Images? image;
  FilePdfResponse? pdf;
  String? roomId;
  String? captainId;
  bool? isCaptainArrived;
  CreatedAt? dateCaptainArrived;
  String? branchPhone;
  num? captainOrderCost;
  String? attention;
  OrderLogsResponse? orderLogs;
  num? kilometer;
  num? paidToProvider;
  bool? orderIsMain;
  List<SubOrder>? subOrders;
  String? captainName;
  String? captainPhone;
  Captain? captainDetails;
  String? storeBranchToClientDistance;
  int? isCashPaymentConfirmedByStore;
  int? primaryOrder;
  String? adminNote;
  Data({
    this.id,
    this.state,
    this.payment,
    this.orderCost,
    this.orderType,
    this.note,
    this.deliveryDate,
    this.createdAt,
    this.storeOrderDetailsId,
    this.destination,
    this.recipientName,
    this.recipientPhone,
    this.detail,
    this.storeOwnerBranchId,
    this.branchName,
    this.image,
    this.roomId,
    this.captainId,
    this.branchPhone,
    this.dateCaptainArrived,
    this.isCaptainArrived,
    this.orderLogs,
    this.attention,
    this.captainOrderCost,
    this.kilometer,
    this.paidToProvider,
    this.orderIsMain,
    this.subOrders,
    this.captainName,
    this.captainPhone,
    this.captainDetails,
    this.pdf,
    this.storeBranchToClientDistance,
    this.isCashPaymentConfirmedByStore,
    this.primaryOrder,
    this.adminNote,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        isCashPaymentConfirmedByStore:
            json['isCashPaymentConfirmedByStore'] as int?,
        state: json['state'] as String?,
        storeBranchToClientDistance: json['storeBranchToClientDistance'] != null
            ? FixedNumber.getFixedNumber(json['storeBranchToClientDistance'])
            : null,
        payment: json['payment'] as String?,
        orderCost: json['orderCost'] as num?,
        orderType: json['orderType'] as int?,
        note: json['note'] as String?,
        captainName: json['captainName'] as String?,
        captainPhone: json['captainPhone'] as String?,
        paidToProvider: json['paidToProvider'] as num?,
        kilometer: json['kilometer'] as num?,
        deliveryDate: json['deliveryDate'] == null
            ? null
            : DeliveryDate.fromJson(
                json['deliveryDate'] as Map<String, dynamic>),
        captainDetails: json['captain'] == null
            ? null
            : Captain.fromJson(json['captain'] as Map<String, dynamic>),
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        storeOrderDetailsId: json['storeOrderDetailsId'] as int?,
        destination: json['destination'] == null
            ? null
            : Destination.fromJson(json['destination'] as Map<String, dynamic>),
        image: json['images'] == null
            ? null
            : Images.fromJson(json['images'] as Map<String, dynamic>),
        pdf: json['filePdf'] == null
            ? null
            : FilePdfResponse.fromJson(json['filePdf'] as Map<String, dynamic>),
        recipientName: json['recipientName'] as String?,
        recipientPhone: json['recipientPhone'] as String?,
        detail: json['detail'] as String?,
        storeOwnerBranchId: json['storeOwnerBranchId'] as int?,
        branchName: json['branchName'] as String?,
        roomId: json['roomId'] as String?,
        captainId: json['captainUserId']?.toString(),
        branchPhone: json['branchPhone']?.toString(),
        isCaptainArrived: json['isCaptainArrived'] as bool?,
        orderIsMain: json['orderIsMain'] as bool?,
        dateCaptainArrived: json['dateCaptainArrived'] == null
            ? null
            : CreatedAt.fromJson(
                json['dateCaptainArrived'] as Map<String, dynamic>),
        attention: json['attention'] as String?,
        captainOrderCost: json['captainOrderCost'] as num?,
        orderLogs: OrderLogsResponse.fromJson(json),
        primaryOrder: json['primaryOrderId'] as int?,
        subOrders: (json['subOrder'] as List<dynamic>?)
            ?.map((e) => SubOrder.fromJson(e as Map<String, dynamic>))
            .toList(),
        adminNote: json['adminNote'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'state': state,
        'payment': payment,
        'orderCost': orderCost,
        'orderType': orderType,
        'note': note,
        'deliveryDate': deliveryDate?.toJson(),
        'createdAt': createdAt?.toJson(),
        'storeOrderDetailsId': storeOrderDetailsId,
        'destination': destination?.toJson(),
        'recipientName': recipientName,
        'recipientPhone': recipientPhone,
        'detail': detail,
        'storeOwnerBranchId': storeOwnerBranchId,
        'branchName': branchName,
      };
}
