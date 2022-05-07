class CaptainCashFinanceRequest {
  String? captainId;
  String? toDate;
  String? fromDate;
  CaptainCashFinanceRequest({this.fromDate, this.captainId, this.toDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['captainId'] = this.captainId;
    if (toDate != null) {
      data['toDate'] = this.toDate;
    }
    if (fromDate != null) {
      data['fromDate'] = this.fromDate;
    }

    return data;
  }
}
