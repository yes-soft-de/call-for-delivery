class AddOfferRequest {
  int? bidOrder;
  num? priceOfferValue;
  String? offerDeadline;

  AddOfferRequest({this.bidOrder,  this.priceOfferValue , this.offerDeadline});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bidDetails'] = this.bidOrder;
    data['priceOfferValue'] = this.priceOfferValue;
    data['offerDeadline'] = this.offerDeadline;

    return data;
  }
}