import 'package:c4d/module_orders/response/order_details_response/file_pdf_response.dart';
import 'package:c4d/module_orders/response/order_details_response/images.dart';
import 'package:c4d/module_orders/response/sub_order_list/sub_order.dart';
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
  String? storeOwnerName;
  Destination? location;
  String? phone;
  String? usedAs;
  num? rating;
  String? ratingComment;
  String? branchPhone;
  int? storeId;
  int? paidToProvider;
  int? isHide;
  bool? orderIsMain;
  List<SubOrder>? subOrders;
  FilePdfResponse? pdf;
  String? storeBranchToClientDistance;
  Data(
      {this.id,
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
      this.location,
      this.phone,
      this.storeOwnerName,
      this.usedAs,
      this.rating,
      this.branchPhone,
      this.ratingComment,
      this.storeId,
      this.paidToProvider,
      this.isHide,
      this.orderIsMain,
      this.subOrders,
      this.pdf,
      this.storeBranchToClientDistance});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as int?,
      state: json['state'] as String?,
      storeBranchToClientDistance:
          json['storeBranchToClientDistance'] as String?,
      pdf: json['filePdf'] == null
          ? null
          : FilePdfResponse.fromJson(json['filePdf'] as Map<String, dynamic>),
      payment: json['payment'] as String?,
      orderCost: json['orderCost'] as num?,
      orderType: json['orderType'] as int?,
      note: json['note'] as String?,
      deliveryDate: json['deliveryDate'] == null
          ? null
          : DeliveryDate.fromJson(json['deliveryDate'] as Map<String, dynamic>),
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
      recipientName: json['recipientName'] as String?,
      recipientPhone: json['recipientPhone'] as String?,
      detail: json['detail'] as String?,
      storeOwnerBranchId: json['storeOwnerBranchId'] as int?,
      branchName: json['branchName'] as String?,
      roomId: json['roomId'] as String?,
      captainId: json['captainUserId']?.toString(),
      phone: json['phone'] as String?,
      storeOwnerName: json['storeOwnerName'] as String?,
      rating: json['rating'],
      ratingComment: json['ratingComment'] as String?,
      branchPhone: json['branchPhone'] as String?,
      location: json['location'] == null
          ? null
          : Destination.fromJson(json['location'] as Map<String, dynamic>),
      usedAs: json['usedAs'] as String?,
      storeId: json['storeId'] as int?,
      isHide: json['isHide'] as int?,
      orderIsMain: json['orderIsMain'] as bool?,
      subOrders: (json['subOrder'] as List<dynamic>?)
          ?.map((e) => SubOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      paidToProvider: json['paidToProvider'] as int?);

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
