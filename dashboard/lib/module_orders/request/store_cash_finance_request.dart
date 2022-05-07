class StoreCashFinanceRequest {
  String? storeId;
  String? toDate;
  String? fromDate;
  StoreCashFinanceRequest({this.fromDate, this.storeId, this.toDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeId'] = this.storeId;
    if (toDate != null) {
      data['toDate'] = this.toDate;
    }
    if (fromDate != null) {
      data['fromDate'] = this.fromDate;
    }

    return data;
  }
}
