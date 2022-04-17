class Datum {
  int? id;
  int? countOrdersInMonth;
  int? salary;
  int? monthCompensation;
  int? bounceMaxCountOrdersInMonth;
  int? bounceMinCountOrdersInMonth;

  Datum({
    this.id,
    this.countOrdersInMonth,
    this.salary,
    this.monthCompensation,
    this.bounceMaxCountOrdersInMonth,
    this.bounceMinCountOrdersInMonth,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        countOrdersInMonth: json['countOrdersInMonth'] as int?,
        salary: json['salary'] as int?,
        monthCompensation: json['monthCompensation'] as int?,
        bounceMaxCountOrdersInMonth:
            json['bounceMaxCountOrdersInMonth'] as int?,
        bounceMinCountOrdersInMonth:
            json['bounceMinCountOrdersInMonth'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'countOrdersInMonth': countOrdersInMonth,
        'salary': salary,
        'monthCompensation': monthCompensation,
        'bounceMaxCountOrdersInMonth': bounceMaxCountOrdersInMonth,
        'bounceMinCountOrdersInMonth': bounceMinCountOrdersInMonth,
      };
}
