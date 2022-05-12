import 'created_at.dart';
import 'delivery_date.dart';
import 'location.dart';

class SubOrder {
  int? id;
  DeliveryDate? deliveryDate;
  CreatedAt? createdAt;
  dynamic payment;
  dynamic orderCost;
  int? orderType;
  dynamic note;
  String? state;
  int? storeOwnerBranchId;
  Location? location;
  String? branchName;
  String? storeOwnerName;

  SubOrder({
    this.id,
    this.deliveryDate,
    this.createdAt,
    this.payment,
    this.orderCost,
    this.orderType,
    this.note,
    this.state,
    this.storeOwnerBranchId,
    this.location,
    this.branchName,
    this.storeOwnerName,
  });

  factory SubOrder.fromJson(Map<String, dynamic> json) => SubOrder(
        id: json['id'] as int?,
        deliveryDate: json['deliveryDate'] == null
            ? null
            : DeliveryDate.fromJson(
                json['deliveryDate'] as Map<String, dynamic>),
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        payment: json['payment'] as dynamic,
        orderCost: json['orderCost'] as dynamic,
        orderType: json['orderType'] as int?,
        note: json['note'] as dynamic,
        state: json['state'] as String?,
        storeOwnerBranchId: json['storeOwnerBranchId'] as int?,
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        branchName: json['branchName'] as String?,
        storeOwnerName: json['storeOwnerName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'deliveryDate': deliveryDate?.toJson(),
        'createdAt': createdAt?.toJson(),
        'payment': payment,
        'orderCost': orderCost,
        'orderType': orderType,
        'note': note,
        'state': state,
        'storeOwnerBranchId': storeOwnerBranchId,
        'location': location?.toJson(),
        'branchName': branchName,
        'storeOwnerName': storeOwnerName,
      };
}
