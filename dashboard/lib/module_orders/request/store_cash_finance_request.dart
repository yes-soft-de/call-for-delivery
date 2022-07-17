class StoreCashFinanceRequest {
  String? storeId;
  String? toDate;
  String? fromDate;
  StoreCashFinanceRequest({this.fromDate, this.storeId, this.toDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    data['storeId'] = this.storeId;
    if (toDate != null) {
      data['toDate'] = DateTime.tryParse(this.toDate ?? '')?.toUtc().toIso8601String();
    }
    if (fromDate != null) {
      data['fromDate'] = DateTime.tryParse(this.fromDate ?? '')?.toUtc().toIso8601String();
    }

    return data;
  }
}
