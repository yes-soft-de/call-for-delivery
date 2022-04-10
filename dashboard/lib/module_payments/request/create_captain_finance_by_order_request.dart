class CreateCaptainFinanceByOrderRequest {
  String? categoryName;
  num? countKilometersFrom;
  num? countKilometersTo;
  num? amount;
  num? bounce;
  num? bounceCountOrdersInMonth;

  CreateCaptainFinanceByOrderRequest({
    this.categoryName,
    this.countKilometersFrom,
    this.countKilometersTo,
    this.amount,
    this.bounce,
    this.bounceCountOrdersInMonth,
  });

  Map<String, dynamic> toJson() => {
        'categoryName': categoryName,
        'countKilometersFrom': countKilometersFrom,
        'countKilometersTo': countKilometersTo,
        'amount': amount,
        'bounce': bounce,
        'bounceCountOrdersInMonth': bounceCountOrdersInMonth,
      };
}
