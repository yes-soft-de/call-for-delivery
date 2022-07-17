class CaptainCashFinanceRequest {
  String? captainId;
  String? toDate;
  String? fromDate;
  CaptainCashFinanceRequest({this.fromDate, this.captainId, this.toDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['captainId'] = this.captainId;
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
