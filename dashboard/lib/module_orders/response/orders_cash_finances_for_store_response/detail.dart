import 'created_at.dart';

class Detail {
  int? id;
  String? storeOwnerName;
  int? orderId;
  num? amount;
  int? flag;
  CreatedAt? createdAt;
  num? storeAmount;
  String? captainNote;
  Detail(
      {this.id,
      this.storeOwnerName,
      this.orderId,
      this.amount,
      this.flag,
      this.createdAt,
      this.captainNote,
      this.storeAmount});

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json['id'] as int?,
        storeOwnerName: json['storeOwnerName'] as String?,
        orderId: json['orderId'] as int?,
        amount: json['amount'] as num?,
        storeAmount: json['storeAmount'] as num?,
        captainNote: json['captainNote'] as String?,
        flag: json['flag'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeOwnerName': storeOwnerName,
        'orderId': orderId,
        'amount': amount,
        'flag': flag,
        'createdAt': createdAt?.toJson(),
      };
}
