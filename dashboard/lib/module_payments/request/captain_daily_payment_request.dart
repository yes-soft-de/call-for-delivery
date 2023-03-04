class CaptainDailyPaymentsRequest {
  int? captainId;
  num? amount;
  String? note;
  int? status;
  int? paymentID;
  CaptainDailyPaymentsRequest({
    this.captainId,
    this.amount,
    this.note,
    this.status,
    this.paymentID,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (captainId != null) {
      map['captainFinancialDailyEntity'] = captainId;
    }
    if (amount != null) {
      map['amount'] = amount;
    }
    if (note != null && note?.isNotEmpty == true) {
      map['note'] = note;
    }
    if (paymentID != null) {
      map['id'] = paymentID;
    }
    if (status != null) {
      map['status'] = status;
    }
    return map;
  }
}
