class FilterBidOrderRequest {
  int? storeId;
  String? toDate;
  String? fromDate;

  bool? openToPriceOffer;
  FilterBidOrderRequest(
      {this.fromDate, this.toDate, this.openToPriceOffer, this.storeId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['toDate'] = this.toDate;
    data['fromDate'] = this.fromDate;

    data['openToPriceOffer'] = this.openToPriceOffer;
    data['storeOwnerProfileId'] = this.storeId;
    return data;
  }
}
