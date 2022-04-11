class Datum {
  int? id;
  String? categoryName;
  num? countKilometersFrom;
  num? countKilometersTo;
  num? amount;
  num? bounce;
  num? bounceCountOrdersInMonth;

  Datum({
    this.id,
    this.categoryName,
    this.countKilometersFrom,
    this.countKilometersTo,
    this.amount,
    this.bounce,
    this.bounceCountOrdersInMonth,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        categoryName: json['categoryName'] as String?,
        countKilometersFrom: json['countKilometersFrom'] as num?,
        countKilometersTo: json['countKilometersTo'] as num?,
        amount: json['amount'] as num?,
        bounce: json['bounce'] as num?,
        bounceCountOrdersInMonth: json['bounceCountOrdersInMonth'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryName': categoryName,
        'countKilometersFrom': countKilometersFrom,
        'countKilometersTo': countKilometersTo,
        'amount': amount,
        'bounce': bounce,
        'bounceCountOrdersInMonth': bounceCountOrdersInMonth,
      };
}
