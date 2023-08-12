import 'package:c4d/utils/helpers/date_converter.dart';

class Payment {
  int? id;
  double? amount;
  DateTime? createdAt;
  int? paymentGetaway;

  Payment({this.id, this.amount, this.createdAt, this.paymentGetaway});

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['id'] as int?,
        amount: (json['amount'] as num?)?.toDouble(),
        createdAt: json['createdAt'] == null
            ? null
            : DateHelper.convert(json['createdAt']['timestamp'] as int?),
        paymentGetaway: json['paymentGetaway'] as int?,
      );
}
