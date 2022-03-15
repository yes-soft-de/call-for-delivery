class Datum {
  int? id;
  int? carCount;
  int? expired;
  double? price;

  Datum({this.id, this.carCount, this.expired, this.price});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        carCount: json['carCount'] as int?,
        expired: json['expired'] as int?,
        price: (json['price'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'carCount': carCount,
        'expired': expired,
        'price': price,
      };
}
