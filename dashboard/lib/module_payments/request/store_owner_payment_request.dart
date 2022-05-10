class CreateStorePaymentsRequest {
  num? amount;
  int? storeId;
  int? id;
  String? note;
  int? flag;
  int? subscriptionId;
  String? fromDate;
  String? toDate;

  CreateStorePaymentsRequest(
      {this.fromDate,
      this.toDate,
      this.subscriptionId,
      this.amount,
      this.storeId,
      this.id,
      this.note,
      this.flag
      });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['store'] = storeId;
    map['amount'] = amount;
    map['note'] = note;
    if (flag != null) {
      map['subscriptionFlag'] = flag;
    }
    if (subscriptionId != null) {
      map['subscriptionId'] = subscriptionId;
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
