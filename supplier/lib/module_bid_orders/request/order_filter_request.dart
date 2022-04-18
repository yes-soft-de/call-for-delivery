class FilterBidOrderRequest {
  String? toDate;
  String? fromDate;
  FilterBidOrderRequest({this.fromDate,  this.toDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
      data['toDate'] = this.toDate;
      data['fromDate'] = this.fromDate;

    return data;
  }
}
