import 'created_at.dart';

class PaymentsFromCompany {
  int? id;
  int? amount;
  CreatedAt? createdAt;
  String? note;

  PaymentsFromCompany({this.id, this.amount, this.createdAt, this.note});

  factory PaymentsFromCompany.fromJson(Map<String, dynamic> json) {
    return PaymentsFromCompany(
      id: json['id'] as int?,
      amount: json['amount'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'createdAt': createdAt?.toJson(),
        'note': note,
      };
}
