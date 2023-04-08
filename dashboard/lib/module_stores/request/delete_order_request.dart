class DeleteOrderRequest {
  int? orderID;
  bool? addHalfOrderValueToCaptainFinancialDue;
  bool? cutOrderFromStoreSubscription;

  DeleteOrderRequest({this.orderID, this.addHalfOrderValueToCaptainFinancialDue, this.cutOrderFromStoreSubscription});

  Map<String, dynamic> toJson() => {
        'id': orderID,
        'addHalfOrderValueToCaptainFinancialDue': addHalfOrderValueToCaptainFinancialDue,
        'cutOrderFromStoreSubscription': cutOrderFromStoreSubscription,
      };
}
