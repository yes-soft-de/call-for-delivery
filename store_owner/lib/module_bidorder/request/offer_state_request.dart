class OfferStateRequest {
  int? bidOrderId;
  int? offerId;
  String? priceOfferStatus;

  OfferStateRequest({this.offerId, this.priceOfferStatus, this.bidOrderId});

  Map<String, dynamic> toJson() {
    return {
      'id': this.offerId,
      'priceOfferStatus': this.priceOfferStatus,
    };
  }
}
