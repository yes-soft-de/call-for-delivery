class FinancialAccountDetail {
  String? categoryName;
  double? countKilometersFrom;
  int? countKilometersTo;
  int? amount;
  int? bounce;
  int? bounceCountOrdersInMonth;
  double? captainTotalCategory;
  double? contOrderCompleted;
  double? countOfOrdersLeft;
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
      countKilometersFrom: (json['countKilometersFrom'] as num?)?.toDouble(),
      countKilometersTo: json['countKilometersTo'] as int?,
      amount: json['amount'] as int?,
      bounce: json['bounce'] as int?,
      bounceCountOrdersInMonth: json['bounceCountOrdersInMonth'] as int?,
      captainTotalCategory: (json['captainTotalCategory'] as num?)?.toDouble(),
      contOrderCompleted: (json['contOrderCompleted'] as num?)?.toDouble(),
      countOfOrdersLeft: (json['countOfOrdersLeft'] as num?)?.toDouble(),
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
