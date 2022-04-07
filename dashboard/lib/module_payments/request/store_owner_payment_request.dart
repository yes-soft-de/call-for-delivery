class CreateStorePaymentsRequest {
  num? amount;
  int? storeId;
  int? id;
  String? note;
  CreateStorePaymentsRequest({this.amount, this.storeId, this.id,this.note});

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        'id': id,
        'amount': amount,
        'store': storeId,
      };
    }
    return {'amount': amount, 'store': storeId, 'note': note};
  }
}
