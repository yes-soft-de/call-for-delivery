class FilterOrderRequest {
  String? state;
  String? toDate;
  String? fromDate;
  String? captainID;
  String? payment;
  FilterOrderRequest({this.fromDate, this.state, this.toDate, this.captainID});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = this.state;
    if (this.captainID != null) {
      data['captainId'] = this.captainID;
    }
    if (toDate != null) {
      data['toDate'] =
          DateTime.tryParse(this.toDate ?? '')?.toUtc().toIso8601String();
    }
    if (fromDate != null) {
      data['fromDate'] =
          DateTime.tryParse(this.fromDate ?? '')?.toUtc().toIso8601String();
    }
    if (payment != null) {
      data['payment'] = this.payment;
    }
    return data;
  }
}
