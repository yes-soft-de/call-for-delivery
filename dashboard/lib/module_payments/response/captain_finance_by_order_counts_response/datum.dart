class Datum {
  int? id;
  num? countOrdersInMonth;
  num? salary;
  num? monthCompensation;
  num? bounceMaxCountOrdersInMonth;
  num? bounceMinCountOrdersInMonth;

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
        countOrdersInMonth: json['countOrdersInMonth'] as num?,
        salary: json['salary'] as int?,
        monthCompensation: json['monthCompensation'] as num?,
        bounceMaxCountOrdersInMonth:
            json['bounceMaxCountOrdersInMonth'] as num?,
        bounceMinCountOrdersInMonth:
            json['bounceMinCountOrdersInMonth'] as num?,
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
