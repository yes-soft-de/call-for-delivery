import 'package:c4d/module_profile/response/captain_payments_response/date.dart';

class Payments {
  int? id;
  num? amount;
  Date? date;
  String? note;

  Payments({
    this.id,
    this.amount,
    this.date,
    this.note,
  });

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        id: json['id'] as int?,
        amount: json['amount'] as num?,
        date: json['createdAt'] == null
            ? null
            : Date.fromJson(json['createdAt'] as Map<String, dynamic>),
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'date': date?.toJson(),
      };
}
