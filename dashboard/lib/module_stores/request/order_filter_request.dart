class FilterOrderRequest {
  int? storeOwnerProfileId;
  String? state;
  String? toDate;
  String? fromDate;
  FilterOrderRequest(
      {this.fromDate, this.state, this.toDate, this.storeOwnerProfileId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = this.state;
    data['storeOwnerProfileId'] = this.storeOwnerProfileId;
    if (toDate != null) {
      data['toDate'] =
          DateTime.tryParse(this.toDate ?? '')?.toUtc().toIso8601String();
    }
    if (fromDate != null) {
      data['fromDate'] =
          DateTime.tryParse(this.fromDate ?? '')?.toUtc().toIso8601String();
    }

    return data;
  }
}
