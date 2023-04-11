import 'captain_payment.dart';
import 'created_at.dart';
import 'updated_at.dart';

class Datum {
  int? id;
  int? captainProfileId;
  String? captainName;
  num? amount;
  num? alreadyHadAmount;
  int? financialSystemType;
  int? financialSystemPlan;
  int? isPaid;
  bool? withBonus;
  num? bonus;
  CreatedAt? createdAt;
  UpdatedAt? updatedAt;
  List<CaptainPayment>? captainPayments;

  Datum({
    this.id,
    this.captainProfileId,
    this.captainName,
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
        captainProfileId: json['captainProfileId'] as int?,
        captainName: json['captainName'] as String?,
        amount: json['amount'] as num?,
        alreadyHadAmount: json['alreadyHadAmount'] as num?,
        financialSystemType: json['financialSystemType'] as int?,
        financialSystemPlan: json['financialSystemPlan'] as int?,
        isPaid: json['isPaid'] as int?,
        withBonus: json['withBonus'] as bool?,
        bonus: json['bonus'] as num?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        updatedAt: json['updatedAt'] == null
            ? null
            : UpdatedAt.fromJson(json['updatedAt'] as Map<String, dynamic>),
        captainPayments: (json['captainPayments'] as List<dynamic>?)
            ?.map((e) => CaptainPayment.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'captainProfileId': captainProfileId,
        'captainName': captainName,
        'amount': amount,
        'alreadyHadAmount': alreadyHadAmount,
        'financialSystemType': financialSystemType,
        'financialSystemPlan': financialSystemPlan,
        'isPaid': isPaid,
        'withBonus': withBonus,
        'bonus': bonus,
        'createdAt': createdAt?.toJson(),
        'updatedAt': updatedAt?.toJson(),
        'captainPayments': captainPayments?.map((e) => e.toJson()).toList(),
      };
}
