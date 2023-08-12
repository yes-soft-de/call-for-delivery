import 'package:c4d/module_orders/response/sub_order_list/sub_order.dart';

import 'created_at.dart';
import 'delivery_date.dart';
import 'destination.dart';

class Datum {
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
  Destination? location;
  int? isHide;
  bool? orderIsMain;
  List<SubOrder>? suborder;
  num? storeBranchToClientDistance;
  String? storeOwnerName;
  num? captainProfit;
  num? profit;

  Datum({
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
    this.location,
    this.isHide,
    this.orderIsMain,
    this.suborder,
    this.storeBranchToClientDistance,
    this.storeOwnerName,
    this.captainProfit,
    this.profit,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        state: json['state'] as String?,
        storeOwnerName: json['storeOwnerName'] as String?,
        payment: json['payment'] as String?,
        orderCost: json['orderCost'] as num?,
        storeBranchToClientDistance:
            json['storeBranchToClientDistance'] as num?,
        orderType: json['orderType'] as int?,
        note: json['note'] as String?,
        captainProfit: json['captainProfit'] as num?,
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
        recipientName: json['recipientName'] as String?,
        recipientPhone: json['recipientPhone'] as String?,
        detail: json['detail'] as String?,
        storeOwnerBranchId: json['storeOwnerBranchId'] as int?,
        branchName: json['branchName'] as String?,
        isHide: json['isHide'] as int?,
        suborder: (json['subOrder'] as List<dynamic>?)
            ?.map((e) => SubOrder.fromJson(e as Map<String, dynamic>))
            .toList(),
        orderIsMain: json['orderIsMain'] as bool?,
        location: json['location'] == null
            ? null
            : Destination.fromJson(json['location'] as Map<String, dynamic>),
        profit: json['profit'] as num?,
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
