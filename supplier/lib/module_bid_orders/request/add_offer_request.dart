class AddOfferRequest {
  int? bidOrder;
  num? priceOfferValue;
  String? offerDeadline;
  String? bidDetails;
  int? deliveryCar;
  num? transportationCount;

  AddOfferRequest({this.bidOrder, this.bidDetails, this.priceOfferValue , this.offerDeadline ,this.deliveryCar ,this.transportationCount});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bidDetails'] = this.bidOrder;
    data['priceOfferValue'] = this.priceOfferValue;
    data['offerDeadline'] = this.offerDeadline;
    data['deliveryCar'] = this.deliveryCar;
    data['transportationCount'] = this.transportationCount;

    return data;
  }
}