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
  num? kilometer;
  num? storeBranchToClientDistance;

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
    this.kilometer,
    this.storeBranchToClientDistance,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        state: json['state'] as String?,
        payment: json['payment'] as String?,
        orderCost: json['orderCost'] as num?,
        orderType: json['orderType'] as int?,
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
        recipientName: json['recipientName'] as String?,
        recipientPhone: json['recipientPhone'] as String?,
        detail: json['detail'] as String?,
        storeOwnerBranchId: json['storeOwnerBranchId'] as int?,
        branchName: json['branchName'] as String?,
        kilometer: json['kilometer'] as num?,
        storeBranchToClientDistance:
            json['storeBranchToClientDistance'] as num?,
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
