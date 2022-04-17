class CreateCaptainFinanceByOrderRequest {
  String? categoryName;
  num? countKilometersFrom;
  num? countKilometersTo;
  num? amount;
  num? bounce;
  num? bounceCountOrdersInMonth;
  int? id;
  CreateCaptainFinanceByOrderRequest(
      {this.categoryName,
      this.countKilometersFrom,
      this.countKilometersTo,
      this.amount,
      this.bounce,
      this.bounceCountOrdersInMonth,
      this.id});

  Map<String, dynamic> toJson() => {
        'categoryName': categoryName,
        'countKilometersFrom': countKilometersFrom,
        'countKilometersTo': countKilometersTo,
        'amount': amount,
        'bounce': bounce,
        'bounceCountOrdersInMonth': bounceCountOrdersInMonth,
      };
  Map<String, dynamic> toJsonWithID() => {
        'id': id,
        'categoryName': categoryName,
        'countKilometersFrom': countKilometersFrom,
        'countKilometersTo': countKilometersTo,
        'amount': amount,
        'bounce': bounce,
        'bounceCountOrdersInMonth': bounceCountOrdersInMonth,
      };
}
