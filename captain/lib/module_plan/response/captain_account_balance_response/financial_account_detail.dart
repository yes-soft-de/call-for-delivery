class FinancialAccountDetail {
  String? categoryName;
  num? countKilometersFrom;
  num? countKilometersTo;
  num? amount;
  num? bounce;
  num? bounceCountOrdersInMonth;
  num? captainTotalCategory;
  num? contOrderCompleted;
  num? countOfOrdersLeft;
  String? message;

  FinancialAccountDetail({
    this.categoryName,
    this.countKilometersFrom,
    this.countKilometersTo,
    this.amount,
    this.bounce,
    this.bounceCountOrdersInMonth,
    this.captainTotalCategory,
    this.contOrderCompleted,
    this.countOfOrdersLeft,
    this.message,
  });

  factory FinancialAccountDetail.fromJson(Map<String, dynamic> json) {
    return FinancialAccountDetail(
      categoryName: json['categoryName'] as String?,
      countKilometersFrom: json['countKilometersFrom'] as num?,
      countKilometersTo: json['countKilometersTo'] as num?,
      amount: (json['amount'] as num?)?.toDouble(),
      bounce: (json['bounce'] as num?)?.toDouble(),
      bounceCountOrdersInMonth: json['bounceCountOrdersInMonth'] as num?,
      captainTotalCategory: json['captainTotalCategory'] as num?,
      contOrderCompleted: json['contOrderCompleted'] as num?,
      countOfOrdersLeft: json['countOfOrdersLeft'] as num?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'categoryName': categoryName,
        'countKilometersFrom': countKilometersFrom,
        'countKilometersTo': countKilometersTo,
        'amount': amount,
        'bounce': bounce,
        'bounceCountOrdersInMonth': bounceCountOrdersInMonth,
        'captainTotalCategory': captainTotalCategory,
        'contOrderCompleted': contOrderCompleted,
        'countOfOrdersLeft': countOfOrdersLeft,
        'message': message,
      };
}
