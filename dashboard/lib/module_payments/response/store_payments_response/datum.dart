import 'date.dart';

class Datum {
  int? id;
  num? amount;
  Date? date;
  String? storeId;
  String? storeOwnerName;

  Datum({
    this.id,
    this.amount,
    this.date,
    this.storeId,
    this.storeOwnerName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        amount: json['amount'] as num?,
        date: json['date'] == null
            ? null
            : Date.fromJson(json['date'] as Map<String, dynamic>),
        storeId: json['storeId'] as String?,
        storeOwnerName: json['storeOwnerName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'date': date?.toJson(),
        'storeId': storeId,
        'storeOwnerName': storeOwnerName,
      };
}
