class FilterOrderOfferRequest {
  String? toDate;
  String? fromDate;
  String? priceOfferStatus;
  bool? openToPriceOffer;
  FilterOrderOfferRequest({this.fromDate,  this.toDate , this.priceOfferStatus ,this.openToPriceOffer});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['toDate'] = this.toDate;
    data['fromDate'] = this.fromDate;
    data['priceOfferStatus'] = this.priceOfferStatus;
    data['openToPriceOffer'] = this.openToPriceOffer;
    return data;
  }
}
