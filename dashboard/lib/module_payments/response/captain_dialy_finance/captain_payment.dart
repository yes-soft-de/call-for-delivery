import 'created_at.dart';

class CaptainPayment {
  int? id;
  num? amount;
  CreatedAt? createdAt;
  String? note;

  CaptainPayment({this.id, this.amount, this.createdAt, this.note});

  factory CaptainPayment.fromJson(Map<String, dynamic> json) {
    return CaptainPayment(
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
