class FilterOrderRequest {
  int? storeOwnerProfileId;
  String? state;
  String? toDate;
  String? fromDate;
  num? maxKilo;
  num? maxKiloFromDistance;
  FilterOrderRequest(
      {this.fromDate,
      this.maxKilo,
      this.maxKiloFromDistance,
      this.state,
      this.toDate,
      this.storeOwnerProfileId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = this.state;
    data['storeOwnerProfileId'] = this.storeOwnerProfileId;
    if (this.maxKiloFromDistance != null) {
      data['storeBranchToClientDistance'] = this.maxKiloFromDistance;
    }
    if (this.maxKilo != null) {
      data['kilometer'] = this.maxKilo;
    }
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
