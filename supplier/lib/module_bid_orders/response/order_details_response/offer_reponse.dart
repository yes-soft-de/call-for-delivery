import 'package:c4d/module_bid_orders/response/created_at.dart';

class OfferResponse{

  int? id;
  num? priceOfferValue;
  String? priceOfferStatus;
  CreatedAt? createdAt;
  CreatedAt? offerDeadline;


  OfferResponse({this.id, this.priceOfferValue, this.priceOfferStatus,
      this.createdAt, this.offerDeadline});

  factory OfferResponse.fromJson(Map<String, dynamic> json) => OfferResponse(
    id: json['id'] as int?,
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