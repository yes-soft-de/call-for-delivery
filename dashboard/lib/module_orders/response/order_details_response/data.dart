import 'dart:convert';

import 'package:c4d/module_orders/response/order_details_response/captain.dart';
import 'package:c4d/module_orders/response/order_details_response/images.dart';
import 'package:c4d/module_orders/response/order_logs_response/data.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:c4d/utils/responses/file_pdf_response.dart';
import '../orders_response/sub_order_list/sub_order.dart';
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
  int? branchId;
  bool? orderIsMain;
  String? captainName;
  String? storeName;
  int? storeId;
  String? noteCaptainOrderCost;
  FilePdfResponse? pdf;
  Captain? captain;
  String? storeBranchToClientDistance;
  List<SubOrder>? subOrders;
  int? primaryOrderId;
  int? packageType;
  int? costType;
  num? orderCostWithDeliveryCost;
  List<ExternalDeliveryOrder>? externalDeliveryOrder;

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
    this.branchId,
    this.orderIsMain,
    this.captainName,
    this.storeName,
    this.storeId,
    this.noteCaptainOrderCost,
    this.pdf,
    this.captain,
    this.storeBranchToClientDistance,
    this.subOrders,
    this.primaryOrderId,
    this.costType,
    this.packageType,
    this.orderCostWithDeliveryCost,
    this.externalDeliveryOrder,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        branchId: json['branchId'],
        id: json['id'] as int?,
        pdf: json['filePdf'] == null
            ? null
            : FilePdfResponse.fromJson(json['filePdf'] as Map<String, dynamic>),
        captain: json['captain'] == null
            ? null
            : Captain.fromJson(json['captain'] as Map<String, dynamic>),
        storeId: json['storeOwnerId'] as int?,
        orderIsMain: json['orderIsMain'] as bool?,
        captainName: json['captainName'],
        noteCaptainOrderCost: json['noteCaptainOrderCost'],
        state: json['state'] as String?,
        payment: json['payment'] as String?,
        orderCost: json['orderCost'] as num?,
        orderType: json['orderType'] as int?,
        note: json['note'] as String?,
        paidToProvider: json['paidToProvider'] as num?,
        kilometer: json['kilometer'] as num?,
        deliveryDate: json['deliveryDate'] == null
            ? null
            : DeliveryDate.fromJson(
                json['deliveryDate'] as Map<String, dynamic>),
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        storeOrderDetailsId: json['storeOrderDetailsId'] as int?,
        destination: json['destination'] == null
            ? null
            : Destination.fromJson(json['destination'] as Map<String, dynamic>),
        image: json['orderImage'] == null
            ? null
            : Images.fromJson(json['orderImage'] as Map<String, dynamic>),
        recipientName: json['recipientName'] as String?,
        recipientPhone: json['recipientPhone'] as String?,
        detail: json['detail'] as String?,
        storeOwnerBranchId: json['storeOwnerBranchId'] as int?,
        branchName: json['branchName'] as String?,
        roomId: json['roomId'] as String?,
        captainId: json['captainUserId']?.toString(),
        branchPhone: json['branchPhone']?.toString(),
        isCaptainArrived: json['isCaptainArrived'] as bool?,
        primaryOrderId: json['primaryOrderId'] as int?,
        dateCaptainArrived: json['dateCaptainArrived'] == null
            ? null
            : CreatedAt.fromJson(
                json['dateCaptainArrived'] as Map<String, dynamic>),
        attention: json['attention'] as String?,
        captainOrderCost: json['captainOrderCost'] as num?,
        storeName: json['storeOwnerName'] as String?,
        storeBranchToClientDistance: json['storeBranchToClientDistance'] != null
            ? FixedNumber.getFixedNumber(json['storeBranchToClientDistance'])
            : null,
        orderLogs: OrderLogsResponse.fromJson(json),
        subOrders: (json['subOrder'] as List<dynamic>?)
            ?.map((e) => SubOrder.fromJson(e as Map<String, dynamic>))
            .toList(),
        costType: json['costType'] as int?,
        packageType: json['packageType'] as int?,
        orderCostWithDeliveryCost: json['deliveryCost'] as num?,
        externalDeliveryOrder: (json['externalDeliveredOrders']
                as List<dynamic>?)
            ?.map(
                (e) => ExternalDeliveryOrder.fromMap(e as Map<String, dynamic>))
            .toList(),
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

class ExternalDeliveryOrder {
  String? id;
  String? companyName;
  int? externalCompanyId;

  ExternalDeliveryOrder({
    this.id,
    this.companyName,
    this.externalCompanyId,
  });

  factory ExternalDeliveryOrder.fromMap(Map<String, dynamic> map) {
    return ExternalDeliveryOrder(
      id: map['id'] != null ? map['id'] as String : null,
      companyName:
          map['companyName'] != null ? map['companyName'] as String : null,
      externalCompanyId: map['externalCompanyId'] != null
          ? map['externalCompanyId'] as int
          : null,
    );
  }

  factory ExternalDeliveryOrder.fromJson(String source) =>
      ExternalDeliveryOrder.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
