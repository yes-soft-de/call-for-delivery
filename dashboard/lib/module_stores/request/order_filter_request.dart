class FilterOrderRequest {
  int? storeOwnerProfileId;
  String? state;
  String? toDate;
  String? fromDate;
  FilterOrderRequest({this.fromDate, this.state, this.toDate ,this.storeOwnerProfileId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = this.state;
    data['storeOwnerProfileId'] = this.storeOwnerProfileId;
    if (toDate != null) {
      data['toDate'] = this.toDate;
    }
    if (fromDate != null) {
      data['fromDate'] = this.fromDate;
    }

    return data;
  }
}
