import 'created_at.dart';

class Payment {
  int? id;
  int? paymentGetaway;
  num? amount;
  CreatedAt? createdAt;

  Payment({this.id, this.amount, this.createdAt, this.paymentGetaway});

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['id'] as int?,
        amount: json['amount'] as num?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        paymentGetaway: json['paymentGetaway'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'createdAt': createdAt?.toJson(),
        'paymentGetaway': paymentGetaway,
      };
}
