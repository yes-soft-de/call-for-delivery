class OrderCashRequest {
  int? orderID;
  int? paid;
  OrderCashRequest({this.orderID, this.paid});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.orderID != null) {
      data['id'] = this.orderID;
    }
    if (this.paid != null) {
      data['isCashPaymentConfirmedByStore'] = this.paid;
    }
    return data;
  }
}
