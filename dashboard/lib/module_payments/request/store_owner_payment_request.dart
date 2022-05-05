class CreateStorePaymentsRequest {
  num? amount;
  int? storeId;
  int? id;
  String? note;
  int? subscriptionId;
  CreateStorePaymentsRequest(
      {this.subscriptionId, this.amount, this.storeId, this.id, this.note});

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        'id': id,
        'amount': amount,
        'store': storeId,
      };
    }
    if (subscriptionId != null) {
      return {
        'amount': amount,
        'store': storeId,
        'note': note,
        'subscriptionId': subscriptionId
      };
    }
    return {'amount': amount, 'store': storeId, 'note': note};
  }
}
