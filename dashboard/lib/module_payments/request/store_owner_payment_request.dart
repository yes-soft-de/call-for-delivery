class CreateStorePaymentsRequest {
  num? amount;
  int? storeId;
  int? id;
  CreateStorePaymentsRequest({this.amount, this.storeId, this.id});

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        'id': id,
        'amount': amount,
        'store': storeId,
      };
    }
    return {
      'amount': amount,
      'store': storeId,
    };
  }
}
