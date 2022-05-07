import 'package:c4d/module_bid_orders/response/created_at.dart';

class OfferResponse{

  int? priceOfferId;
  num? priceOfferValue;
  String? priceOfferStatus;
  CreatedAt? createdAt;
  CreatedAt? offerDeadline;


  OfferResponse({this.priceOfferId, this.priceOfferValue, this.priceOfferStatus,
      this.createdAt, this.offerDeadline});

  factory OfferResponse.fromJson(Map<String, dynamic> json) => OfferResponse(
    priceOfferId: json['priceOfferId'] as int?,
    priceOfferValue: json['priceOfferValue'] as num?,
    priceOfferStatus: json['priceOfferStatus'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
    offerDeadline: json['offerDeadline'] == null
        ? null
        : CreatedAt.fromJson(json['offerDeadline'] as Map<String, dynamic>),
  );
}