class CreateCaptainFinanceByHoursRequest {
  num? countHours;
  num? compensationForEveryOrder;
  num? salary;
  int? id;

  CreateCaptainFinanceByHoursRequest(
      {this.countHours, this.compensationForEveryOrder, this.salary, this.id});

  Map<String, dynamic> toJson() => {
        'countHours': countHours,
        'compensationForEveryOrder': compensationForEveryOrder,
        'salary': salary,
      };

  Map<String, dynamic> toJsonWithID() => {
        'id': id,
        'countHours': countHours,
        'compensationForEveryOrder': compensationForEveryOrder,
        'salary': salary,
      };
}
