class OrderNonSubRequest {
  int? orderID;
  OrderNonSubRequest({
    this.orderID,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.orderID != null) {
      data['orderId'] = this.orderID;
    }
    return data;
  }
}
