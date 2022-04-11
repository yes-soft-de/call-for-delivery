class CreateCaptainFinanceByCountOrderRequest {
  num? countOrdersInMonth;
  num? salary;
  num? monthCompensation;
  num? bounceMaxCountOrdersInMonth;
  num? bounceMinCountOrdersInMonth;

  CreateCaptainFinanceByCountOrderRequest({
    this.countOrdersInMonth,
    this.salary,
    this.monthCompensation,
    this.bounceMaxCountOrdersInMonth,
    this.bounceMinCountOrdersInMonth,
  });


  Map<String, dynamic> toJson() => {
        'countOrdersInMonth': countOrdersInMonth,
        'salary': salary,
        'monthCompensation': monthCompensation,
        'bounceMaxCountOrdersInMonth': bounceMaxCountOrdersInMonth,
        'bounceMinCountOrdersInMonth': bounceMinCountOrdersInMonth,
      };
}
