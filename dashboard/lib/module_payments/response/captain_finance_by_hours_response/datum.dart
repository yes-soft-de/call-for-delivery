class Datum {
  int? id;
  int? countHours;
  num? compensationForEveryOrder;
  num? salary;

  Datum({
    this.id,
    this.countHours,
    this.compensationForEveryOrder,
    this.salary,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        countHours: json['countHours'] as int?,
        compensationForEveryOrder: json['compensationForEveryOrder'] as num?,
        salary: json['salary'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'countHours': countHours,
        'compensationForEveryOrder': compensationForEveryOrder,
        'salary': salary,
      };
}
