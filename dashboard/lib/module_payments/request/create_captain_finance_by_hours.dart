class CreateCaptainFinanceByHoursRequest {
  int? countHours;
  int? compensationForEveryOrder;
  int? salary;

  CreateCaptainFinanceByHoursRequest({
    this.countHours,
    this.compensationForEveryOrder,
    this.salary,
  });

  factory CreateCaptainFinanceByHoursRequest.fromJson(
      Map<String, dynamic> json) {
    return CreateCaptainFinanceByHoursRequest(
      countHours: json['countHours'] as int?,
      compensationForEveryOrder: json['compensationForEveryOrder'] as int?,
      salary: json['salary'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'countHours': countHours,
        'compensationForEveryOrder': compensationForEveryOrder,
        'salary': salary,
      };
}
