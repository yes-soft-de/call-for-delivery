import 'created_at.dart';

class Detail {
  int? id;
  String? captainName;
  int? orderId;
  int? amount;
  int? flag;
  CreatedAt? createdAt;

  Detail({
    this.id,
    this.captainName,
    this.orderId,
    this.amount,
    this.flag,
    this.createdAt,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json['id'] as int?,
        captainName: json['captainName'] as String?,
        orderId: json['orderId'] as int?,
        amount: json['amount'] as int?,
        flag: json['flag'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'captainName': captainName,
        'orderId': orderId,
        'amount': amount,
        'flag': flag,
        'createdAt': createdAt?.toJson(),
      };
}
