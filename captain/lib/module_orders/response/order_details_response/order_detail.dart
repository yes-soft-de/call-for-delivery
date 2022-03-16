import 'package:c4d/module_orders/response/order_details_response/destination.dart';
import 'package:c4d/module_orders/response/order_details_response/product_image.dart';

import 'product.dart';

class OrderDetail {
  int? orderDetailId;
  int? orderId;
  int? storeOwnerProfileId;
  String? storeOwnerName;
  String? phone;
  ProductImage? image;
  int? storeCategoryId;
  ProductImage? invoiceImage;
  num? invoiceAmount;
  List<Product>? products;
  String? state;
  Destination? location;
  String? roomID;
  String? storeOwnerID;
  OrderDetail(
      {this.orderDetailId,
      this.orderId,
      this.storeOwnerProfileId,
      this.storeOwnerName,
      this.phone,
      this.image,
      this.storeCategoryId,
      this.products,
      this.invoiceAmount,
      this.invoiceImage,
      this.location,
      this.state,
      this.roomID,
      this.storeOwnerID
      });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
      orderDetailId: json['orderDetailID'] as int?,
      orderId: json['orderID'] as int?,
      storeOwnerProfileId: json['storeOwnerProfileID'] as int?,
      storeOwnerID: json['storeOwnerID'] as String?,
      storeOwnerName: json['storeOwnerName'] as String?,
      phone: json['phone'] as String?,
      state: json['state'],
      roomID: json['roomID'],
      image: json['image'] == null
          ? null
          : ProductImage.fromJson(json['image'] as Map<String, dynamic>),
      location: json['location'] == null || json['location'] is List
          ? null
          : Destination.fromJson(json['location'] as Map<String, dynamic>),
      storeCategoryId: json['storeCategoryId'] as int?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoiceAmount: json['invoiceAmount'] as num?,
      invoiceImage: json['invoiceImage'] == null
          ? null
          : ProductImage.fromJson(
              json['invoiceImage'] as Map<String, dynamic>));

  Map<String, dynamic> toJson() => {
        'orderDetailID': orderDetailId,
        'orderID': orderId,
        'storeOwnerProfileID': storeOwnerProfileId,
        'storeOwnerName': storeOwnerName,
        'phone': phone,
        'image': image,
        'storeCategoryId': storeCategoryId,
        'products': products?.map((e) => e.toJson()).toList(),
      };
}
