import 'package:c4d/module_bid_orders/response/created_at.dart';
import 'package:c4d/module_bid_orders/response/order_details_response/offer_reponse.dart';
import 'package:c4d/module_profile/response/profile_response/images.dart';

class Datum{
  int? id;
  String? title;
  String? description;
  bool? openToPriceOffer;
  CreatedAt? createdAt;
  List<Images>?  images;
  List<OfferResponse>? offers;

  Datum({this.id, this.title, this.description, this.createdAt, this.images,

      this.offers,this.openToPriceOffer});
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json['id'] as int?,
    title: json['title'] as String?,
    description: json['description'] as String?,

    createdAt: json['createdAt'] == null
        ? null
        : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),

    images:json['images']== null ? []: (json['images'] as List<dynamic>?)
        ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
        .toList(),

    offers: (json['priceOfferEntities'] as List<dynamic>?)
        ?.map((e) => OfferResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
    openToPriceOffer: json['openToPriceOffer'] as bool?
  );

}