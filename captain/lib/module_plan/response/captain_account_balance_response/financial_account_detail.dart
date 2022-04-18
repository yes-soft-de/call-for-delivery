class FinancialAccountDetail {
  String? categoryName;
  int? countKilometersFrom;
  int? countKilometersTo;
  double? amount;
  double? bounce;
  int? bounceCountOrdersInMonth;
  int? captainTotalCategory;
  int? contOrderCompleted;
  int? countOfOrdersLeft;
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
      countKilometersFrom: json['countKilometersFrom'] as int?,
      countKilometersTo: json['countKilometersTo'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
      bounce: (json['bounce'] as num?)?.toDouble(),
      bounceCountOrdersInMonth: json['bounceCountOrdersInMonth'] as int?,
      captainTotalCategory: json['captainTotalCategory'] as int?,
      contOrderCompleted: json['contOrderCompleted'] as int?,
      countOfOrdersLeft: json['countOfOrdersLeft'] as int?,
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
