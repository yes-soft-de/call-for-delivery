class CreateCaptainFinanceByOrderRequest {
  String? categoryName;
  int? countKilometersFrom;
  double? countKilometersTo;
  int? amount;
  double? bounce;
  double? bounceCountOrdersInMonth;

  CreateCaptainFinanceByOrderRequest({
    this.categoryName,
    this.countKilometersFrom,
    this.countKilometersTo,
    this.amount,
    this.bounce,
    this.bounceCountOrdersInMonth,
  });

  factory CreateCaptainFinanceByOrderRequest.fromJson(
      Map<String, dynamic> json) {
    return CreateCaptainFinanceByOrderRequest(
      categoryName: json['categoryName'] as String?,
      countKilometersFrom: json['countKilometersFrom'] as int?,
      countKilometersTo: (json['countKilometersTo'] as num?)?.toDouble(),
      amount: json['amount'] as int?,
      bounce: (json['bounce'] as num?)?.toDouble(),
      bounceCountOrdersInMonth:
          (json['bounceCountOrdersInMonth'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'categoryName': categoryName,
        'countKilometersFrom': countKilometersFrom,
        'countKilometersTo': countKilometersTo,
        'amount': amount,
        'bounce': bounce,
        'bounceCountOrdersInMonth': bounceCountOrdersInMonth,
      };
}
