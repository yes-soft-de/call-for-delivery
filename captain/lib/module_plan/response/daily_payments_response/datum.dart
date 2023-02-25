import 'package:c4d/module_profile/response/daily_finance_response/payments.dart';

import 'created_at.dart';
import 'updated_at.dart';

class Datum {
  int? id;
  int? amount;
  int? alreadyHadAmount;
  int? financialSystemType;
  int? financialSystemPlan;
  int? isPaid;
  bool? withBonus;
  int? bonus;
  CreatedAt? createdAt;
  UpdatedAt? updatedAt;
  List<Payments>? captainPayments;

  Datum({
    this.id,
    this.amount,
    this.alreadyHadAmount,
    this.financialSystemType,
    this.financialSystemPlan,
    this.isPaid,
    this.withBonus,
    this.bonus,
    this.createdAt,
    this.updatedAt,
    this.captainPayments,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        amount: json['amount'] as int?,
        alreadyHadAmount: json['alreadyHadAmount'] as int?,
        financialSystemType: json['financialSystemType'] as int?,
        financialSystemPlan: json['financialSystemPlan'] as int?,
        isPaid: json['isPaid'] as int?,
        withBonus: json['withBonus'] as bool?,
        bonus: json['bonus'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        updatedAt: json['updatedAt'] == null
            ? null
            : UpdatedAt.fromJson(json['updatedAt'] as Map<String, dynamic>),
        captainPayments: (json['captainPayments'] as List<dynamic>?)
            ?.map((e) => Payments.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'alreadyHadAmount': alreadyHadAmount,
        'financialSystemType': financialSystemType,
        'financialSystemPlan': financialSystemPlan,
        'isPaid': isPaid,
        'withBonus': withBonus,
        'bonus': bonus,
        'createdAt': createdAt?.toJson(),
        'updatedAt': updatedAt?.toJson(),
        'captainPayments': captainPayments,
      };
}
