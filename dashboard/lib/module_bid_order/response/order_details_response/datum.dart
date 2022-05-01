

import 'package:c4d/module_bid_order/response/order_details_response/order_logs_response/data.dart';
import 'package:c4d/module_stores/response/order/order_details_response/images.dart';

import '../../../module_captain/response/captain_financial_dues_response/created_at.dart';
import 'offer_reponse.dart';

class Datum{
  int? id;
  int? bidDetailsId;
  String? title;
  String? payment;
  String? description;
  String? note;
  String? state;
  bool? openToPriceOffer;
  CreatedAt? createdAt;
  CreatedAt? deliveryDate;
  List<Images>?  images;
  List<OfferResponse>? offers;
  OrderLogsResponse? orderLogs;

  Datum({this.id, this.title, this.description, this.createdAt, this.images,this.orderLogs,

      this.offers,this.openToPriceOffer, required this.bidDetailsId ,this.deliveryDate,required this.payment ,required this.note ,required this.state});
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json['id'] as int?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    payment: json['payment'] as String?,
      note: json['note'] as String?,
      state: json['state'] as String?,

    createdAt: json['createdAt'] == null
        ? null
        : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),

      deliveryDate: json['deliveryDate'] == null
        ? null
        : CreatedAt.fromJson(json['deliveryDate'] as Map<String, dynamic>),

    images:json['bidDetailsImages']== null ? []: (json['bidDetailsImages'] as List<dynamic>?)
        ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
        .toList(),

    offers: (json['pricesOffers'] as List<dynamic>?)
        ?.map((e) => OfferResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
    openToPriceOffer: json['openToPriceOffer'] as bool?,
    bidDetailsId: json['bidDetailsId'] as int?,
    orderLogs: OrderLogsResponse.fromJson(json));

}