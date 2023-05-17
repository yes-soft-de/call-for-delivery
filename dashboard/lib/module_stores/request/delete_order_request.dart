class DeleteOrderRequest {
  int? orderID;
  bool? addHalfOrderValueToCaptainFinancialDue;
  bool? cutOrderFromStoreSubscription;

  DeleteOrderRequest(
      {this.orderID,
      this.addHalfOrderValueToCaptainFinancialDue,
      this.cutOrderFromStoreSubscription});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = orderID;
    if (addHalfOrderValueToCaptainFinancialDue != null) {
      map['addHalfOrderValueToCaptainFinancialDue'] =
          addHalfOrderValueToCaptainFinancialDue;
    }
    if (cutOrderFromStoreSubscription != null) {
      map['cutOrderFromStoreSubscription'] = cutOrderFromStoreSubscription;
    }
    return map;
  }
}
