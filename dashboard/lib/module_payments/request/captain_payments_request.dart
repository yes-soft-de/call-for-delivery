class CaptainPaymentsRequest {
  int? captainId;
  num? amount;
  String? note;
  int? status;
  int? captainFinancialDuesId;

  CaptainPaymentsRequest(
      {this.captainFinancialDuesId,
      this.status,
      this.captainId,
      this.amount,
      this.note});

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
    map['status'] = status;
    map['captainFinancialDuesId'] = captainFinancialDuesId;

    return map;
  }
}
