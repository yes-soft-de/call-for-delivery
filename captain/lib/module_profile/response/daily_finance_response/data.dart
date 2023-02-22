import 'package:c4d/module_profile/response/daily_finance_response/payments.dart';

import 'updated_at.dart';

class Data {
  int? id;
  num? amount;
  num? alreadyHadAmount;
  int? isPaid;
  bool? withBonus;
  num? bonus;
  UpdatedAt? updatedAt;
  List<Payments>? captainPayments;

  Data({
    this.id,
    this.amount,
    this.alreadyHadAmount,
    this.isPaid,
    this.withBonus,
    this.bonus,
    this.updatedAt,
    this.captainPayments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        amount: json['amount'] as num?,
        alreadyHadAmount: json['alreadyHadAmount'] as num?,
        isPaid: json['isPaid'] as int?,
        withBonus: json['withBonus'] as bool?,
        bonus: json['bonus'] as num?,
        captainPayments: (json['captainPayments'] as List<dynamic>?)
            ?.map((e) => Payments.fromJson(e as Map<String, dynamic>))
            .toList(),
        updatedAt: json['updatedAt'] == null
            ? null
            : UpdatedAt.fromJson(json['updatedAt'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'alreadyHadAmount': alreadyHadAmount,
        'isPaid': isPaid,
        'withBonus': withBonus,
        'bonus': bonus,
        'updatedAt': updatedAt?.toJson(),
      };
}
