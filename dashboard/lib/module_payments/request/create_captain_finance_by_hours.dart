class CreateCaptainFinanceByHoursRequest {
  num? countHours;
  num? compensationForEveryOrder;
  num? salary;

  CreateCaptainFinanceByHoursRequest({
    this.countHours,
    this.compensationForEveryOrder,
    this.salary,
  });

  Map<String, dynamic> toJson() => {
        'countHours': countHours,
        'compensationForEveryOrder': compensationForEveryOrder,
        'salary': salary,
      };
}
