class AddOfferRequest {
  int? bidOrder;
  num? priceOfferValue;
  String? offerDeadline;
  String? bidDetails;
  int? deliveryCar;

  AddOfferRequest({this.bidOrder, this.bidDetails, this.priceOfferValue , this.offerDeadline ,this.deliveryCar});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bidDetails'] = this.bidOrder;
    data['priceOfferValue'] = this.priceOfferValue;
    data['offerDeadline'] = this.offerDeadline;
    data['deliveryCar'] = this.deliveryCar;
//    data['bidDetails'] = this.bidDetails;

    return data;
  }
}