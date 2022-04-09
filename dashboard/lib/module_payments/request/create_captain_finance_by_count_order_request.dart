class CreateCaptainFinanceByCountOrderRequest {
  int? countOrdersInMonth;
  int? salary;
  double? monthCompensation;
  int? bounceMaxCountOrdersInMonth;
  double? bounceMinCountOrdersInMonth;

  CreateCaptainFinanceByCountOrderRequest({
    this.countOrdersInMonth,
    this.salary,
    this.monthCompensation,
    this.bounceMaxCountOrdersInMonth,
    this.bounceMinCountOrdersInMonth,
  });

  factory CreateCaptainFinanceByCountOrderRequest.fromJson(
      Map<String, dynamic> json) {
    return CreateCaptainFinanceByCountOrderRequest(
      countOrdersInMonth: json['countOrdersInMonth'] as int?,
      salary: json['salary'] as int?,
      monthCompensation: (json['monthCompensation'] as num?)?.toDouble(),
      bounceMaxCountOrdersInMonth: json['bounceMaxCountOrdersInMonth '] as int?,
      bounceMinCountOrdersInMonth:
          (json['bounceMinCountOrdersInMonth '] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'countOrdersInMonth': countOrdersInMonth,
        'salary': salary,
        'monthCompensation': monthCompensation,
        'bounceMaxCountOrdersInMonth ': bounceMaxCountOrdersInMonth,
        'bounceMinCountOrdersInMonth ': bounceMinCountOrdersInMonth,
      };
}
