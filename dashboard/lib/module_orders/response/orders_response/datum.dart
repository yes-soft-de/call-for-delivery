import 'package:c4d/module_orders/response/orders_response/sub_order_list/sub_order.dart';
import 'created_at.dart';
import 'delivery_date.dart';
import 'destination.dart';

class DatumOrder {
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
  Destination? location;
  String? recipientName;
  String? recipientPhone;
  String? detail;
  int? storeOwnerBranchId;
  String? branchName;
  String? storeOwnerName;
  bool? orderIsMain;
  List<SubOrder>? subOrders;
  int? isCashPaymentConfirmedByStore;
  int? paidToProvider;
  String? captainName;
  dynamic? captainProfileId;
  num? kilometer;
  num? storeBranchToClientDistance;
  String? storeBranchToClientDistanceAdditionExplanation;
  int? costType;
  int? packageType;
  DatumOrder({
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
    this.storeOwnerName,
    this.orderIsMain,
    this.subOrders,
    this.location,
    this.isCashPaymentConfirmedByStore,
    this.paidToProvider,
    this.captainName,
    this.captainProfileId,
    this.kilometer,
    this.storeBranchToClientDistance,
    this.storeBranchToClientDistanceAdditionExplanation,
    this.costType,
    this.packageType,
  });

  factory DatumOrder.fromJson(Map<String, dynamic> json) => DatumOrder(
        id: json['id'] as int?,
        state: json['state'] as String?,
        payment: json['payment'] as String?,
        orderCost: json['orderCost'] as num?,
        kilometer: json['kilometer'] as num?,
        storeBranchToClientDistance:
            json['storeBranchToClientDistance'] as num?,
        orderType: json['orderType'] as int?,
        storeOwnerName: json['storeOwnerName'] as String?,
        paidToProvider: json['paidToProvider'] as int?,
        captainName: json['captainName'] as String?,
        captainProfileId: json['captainProfileId'],
        isCashPaymentConfirmedByStore:
            json['isCashPaymentConfirmedByStore'] as int?,
        note: json['note'] as String?,
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
        location: json['location'] == null
            ? null
            : Destination.fromJson(json['location'] as Map<String, dynamic>),
        recipientName: json['recipientName'] as String?,
        recipientPhone: json['recipientPhone'] as String?,
        detail: json['detail'] as String?,
        storeOwnerBranchId: json['storeOwnerBranchId'] as int?,
        branchName: json['branchName'] as String?,
        orderIsMain: json['orderIsMain'] as bool?,
        storeBranchToClientDistanceAdditionExplanation:
            json['storeBranchToClientDistanceAdditionExplanation'] as String?,
        costType: json['costType'] as int?,
        packageType: json['packageType'] as int?,
        subOrders: (json['subOrder'] as List<dynamic>?)
            ?.map((e) => SubOrder.fromJson(e as Map<String, dynamic>))
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
