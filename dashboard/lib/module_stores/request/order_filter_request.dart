class FilterOrderRequest {
  int? storeOwnerProfileId;
  String? state;
  DateTime? toDate;
  DateTime? fromDate;
  num? maxKilo;
  num? maxKiloFromDistance;
  int? chosenDistanceIndicator;
  FilterOrderRequest({
    this.fromDate,
    this.maxKilo,
    this.maxKiloFromDistance,
    this.state,
    this.toDate,
    this.storeOwnerProfileId,
    this.chosenDistanceIndicator,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = this.state;
    data['storeOwnerProfileId'] = this.storeOwnerProfileId;
    data['chosenDistanceIndicator'] = this.chosenDistanceIndicator ?? 0;
    if (this.maxKiloFromDistance != null) {
      data['storeBranchToClientDistance'] = this.maxKiloFromDistance;
    }
    if (this.maxKilo != null) {
      data['kilometer'] = this.maxKilo;
    }
    if (toDate != null) {
      data['toDate'] = DateTime(
              this.toDate!.year, this.toDate!.month, this.toDate!.day + 1, 0)
          .toUtc()
          .toIso8601String();
    }
    if (fromDate != null) {
      data['fromDate'] = DateTime(
              this.fromDate!.year, this.fromDate!.month, this.fromDate!.day, 0)
          .toUtc()
          .toIso8601String();
    }

    return data;
  }
}
