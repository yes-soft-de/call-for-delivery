class FilterBidOrderRequest {
  String? state;
  String? fromDate;
  String? toDate;
  bool? openToPriceOffer;

  FilterBidOrderRequest(
      {this.state, this.fromDate, this.toDate, this.openToPriceOffer});

  Map<String, dynamic> toJson() {
    return {
      'state': this.state,
      'fromDate': this.fromDate,
      'toDate': this.toDate,
      'openToPriceOffer': this.openToPriceOffer,
    };
  }
}
