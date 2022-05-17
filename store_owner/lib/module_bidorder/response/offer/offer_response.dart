
import '../../../module_orders/response/orders_response/created_at.dart';

class OffersResponse {
  List<Data>? data;
  String? statusCode;
  OffersResponse({this.data});

  OffersResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? details;
  CreatedAt? createdAt;
  CreatedAt? deliveryDate;

  num? priceOfferValue;
  num? transportationCount;
  num? totalDeliveryCost;
  num? profitMargin;

  String? priceOfferStatus;
  String? carModel;

  Data({this.id,this.details , this.profitMargin ,this.transportationCount , this.deliveryDate ,this.carModel,this.priceOfferStatus,this.priceOfferValue ,this.createdAt,this.totalDeliveryCost});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'] as int?,
    details: json['details'] as String?,
    priceOfferStatus: json['priceOfferStatus'] as String?,
    carModel: json['carModel'] as String?,

    deliveryDate: json['offerDeadline'] == null
        ? null
        : CreatedAt.fromJson(
        json['offerDeadline'] as Map<String, dynamic>),
    createdAt: json['createdAt'] == null
        ? null
        : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),

    priceOfferValue: json['priceOfferValue'] as int?,
    transportationCount: json['transportationCount'] as int?,
    totalDeliveryCost: json['totalDeliveryCost'] as int?,
    profitMargin: json['profitMargin'] as num?,

  );
}