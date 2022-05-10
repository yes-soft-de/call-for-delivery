class CaptainPaymentsRequest {
  int? captainId;
  num? amount;
  String? note;
  int? status;
  int? captainFinancialDuesId;
  String? fromDate;
  String? toDate;
  CaptainPaymentsRequest(
      {this.captainFinancialDuesId,
      this.status,
      this.captainId,
      this.amount,
      this.note,
      this.fromDate,
      this.toDate});

  CaptainPaymentsRequest.fromJson(dynamic json) {
    captainId = json['captainId'];
    amount = json['amount'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['captain'] = captainId;
    map['amount'] = amount;
    map['note'] = note;
    if (status != null) {
      map['status'] = status;
    }
    if (captainFinancialDuesId != null) {
      map['captainFinancialDuesId'] = captainFinancialDuesId;
    }
    if (fromDate != null) {
      map['fromDate'] = fromDate;
    }
    if (toDate != null) {
      map['toDate'] = toDate;
    }
    return map;
  }

}
