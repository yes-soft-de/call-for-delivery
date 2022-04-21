class CreateCaptainFinanceByCountOrderRequest {
  num? countOrdersInMonth;
  num? salary;
  num? monthCompensation;
  num? bounceMaxCountOrdersInMonth;
  num? bounceMinCountOrdersInMonth;
  int? id;
  CreateCaptainFinanceByCountOrderRequest({
    this.countOrdersInMonth,
    this.salary,
    this.monthCompensation,
    this.bounceMaxCountOrdersInMonth,
    this.bounceMinCountOrdersInMonth,
    this.id
  });

  Map<String, dynamic> toJson() => {
        'countOrdersInMonth': countOrdersInMonth,
        'salary': salary,
        'monthCompensation': monthCompensation,
        'bounceMaxCountOrdersInMonth': bounceMaxCountOrdersInMonth,
        'bounceMinCountOrdersInMonth': bounceMinCountOrdersInMonth,
      };
      Map<String, dynamic> toJsonWithID() => {
        'id':id,
        'countOrdersInMonth': countOrdersInMonth,
        'salary': salary,
        'monthCompensation': monthCompensation,
        'bounceMaxCountOrdersInMonth': bounceMaxCountOrdersInMonth,
        'bounceMinCountOrdersInMonth': bounceMinCountOrdersInMonth,
      };
}
