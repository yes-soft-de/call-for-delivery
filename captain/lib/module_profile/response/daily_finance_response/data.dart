import 'updated_at.dart';

class Data {
  int? id;
  int? amount;
  int? alreadyHadAmount;
  int? isPaid;
  bool? withBonus;
  int? bonus;
  UpdatedAt? updatedAt;

  Data({
    this.id,
    this.amount,
    this.alreadyHadAmount,
    this.isPaid,
    this.withBonus,
    this.bonus,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        amount: json['amount'] as int?,
        alreadyHadAmount: json['alreadyHadAmount'] as int?,
        isPaid: json['isPaid'] as int?,
        withBonus: json['withBonus'] as bool?,
        bonus: json['bonus'] as int?,
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
