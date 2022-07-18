import 'created_at.dart';

class FinishedPayment {
  int? id;
  String? captainName;
  int? orderId;
  num? amount;
  int? flag;
  num? storeAmount;
  String? captainNote;
  CreatedAt? createdAt;

  FinishedPayment({
    this.id,
    this.captainName,
    this.orderId,
    this.amount,
    this.flag,
    this.storeAmount,
    this.captainNote,
    this.createdAt,
  });

  factory FinishedPayment.fromJson(Map<String, dynamic> json) {
    return FinishedPayment(
      id: json['id'] as int?,
      captainName: json['captainName'] as String?,
      orderId: json['orderId'] as int?,
      amount: json['amount'] as num?,
      flag: json['flag'] as int?,
      storeAmount: json['storeAmount'] as num?,
      captainNote: json['captainNote'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'captainName': captainName,
        'orderId': orderId,
        'amount': amount,
        'flag': flag,
        'storeAmount': storeAmount,
        'captainNote': captainNote,
        'createdAt': createdAt?.toJson(),
      };
}
