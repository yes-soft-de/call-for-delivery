class ConfirmOfferRequest {
  int? id;
  String? priceOfferStatus;
  ConfirmOfferRequest({this.id,  this.priceOfferStatus});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['priceOfferStatus'] = this.priceOfferStatus;

    return data;
  }
}
