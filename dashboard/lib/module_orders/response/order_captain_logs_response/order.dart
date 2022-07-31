import 'created_at.dart';
import 'delivery_date.dart';
import 'destination.dart';
import 'location.dart';
import 'updated_at.dart';

class Order {
  int? id;
  String? state;
  String? payment;
  int? orderCost;
  int? orderType;
  String? note;
  DeliveryDate? deliveryDate;
  CreatedAt? createdAt;
  UpdatedAt? updatedAt;
  int? kilometer;
  int? storeOrderDetailsId;
  Destination? destination;
  String? recipientName;
  String? recipientPhone;
  String? detail;
  int? storeOwnerBranchId;
  Location? location;
  String? branchName;
  dynamic imageId;
  dynamic images;
  dynamic countOrders;

  Order({
    this.id,
    this.state,
    this.payment,
    this.orderCost,
    this.orderType,
    this.note,
    this.deliveryDate,
    this.createdAt,
    this.updatedAt,
    this.kilometer,
    this.storeOrderDetailsId,
    this.destination,
    this.recipientName,
    this.recipientPhone,
    this.detail,
    this.storeOwnerBranchId,
    this.location,
    this.branchName,
    this.imageId,
    this.images,
    this.countOrders,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'] as int?,
        state: json['state'] as String?,
        payment: json['payment'] as String?,
        orderCost: json['orderCost'] as int?,
        orderType: json['orderType'] as int?,
        note: json['note'] as String?,
        deliveryDate: json['deliveryDate'] == null
            ? null
            : DeliveryDate.fromJson(
                json['deliveryDate'] as Map<String, dynamic>),
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        updatedAt: json['updatedAt'] == null
            ? null
            : UpdatedAt.fromJson(json['updatedAt'] as Map<String, dynamic>),
        kilometer: json['kilometer'] as int?,
        storeOrderDetailsId: json['storeOrderDetailsId'] as int?,
        destination: json['destination'] == null
            ? null
            : Destination.fromJson(json['destination'] as Map<String, dynamic>),
        recipientName: json['recipientName'] as String?,
        recipientPhone: json['recipientPhone'] as String?,
        detail: json['detail'] as String?,
        storeOwnerBranchId: json['storeOwnerBranchId'] as int?,
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        branchName: json['branchName'] as String?,
        imageId: json['imageId'] as dynamic,
        images: json['images'] as dynamic,
        countOrders: json['countOrders'] as dynamic,
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
        'updatedAt': updatedAt?.toJson(),
        'kilometer': kilometer,
        'storeOrderDetailsId': storeOrderDetailsId,
        'destination': destination?.toJson(),
        'recipientName': recipientName,
        'recipientPhone': recipientPhone,
        'detail': detail,
        'storeOwnerBranchId': storeOwnerBranchId,
        'location': location?.toJson(),
        'branchName': branchName,
        'imageId': imageId,
        'images': images,
        'countOrders': countOrders,
      };
}
