class Datum {
  int? id;
  String? categoryName;
  int? countKilometersFrom;
  int? countKilometersTo;
  double? amount;
  double? bounce;
  int? bounceCountOrdersInMonth;

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
        countKilometersFrom: json['countKilometersFrom'] as int?,
        countKilometersTo: json['countKilometersTo'] as int?,
        amount: (json['amount'] as num?)?.toDouble(),
        bounce: (json['bounce'] as num?)?.toDouble(),
        bounceCountOrdersInMonth: json['bounceCountOrdersInMonth'] as int?,
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
