import 'created_at.dart';

class Datum {
  num? id;
  num? amount;
  CreatedAt? createdAt;
  String? captainId;
  String? captainName;
  String? note;

  Datum({
    this.id,
    this.amount,
    this.createdAt,
    this.captainId,
    this.captainName,
    this.note,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        amount: json['amount'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        captainId: json['captainId'] as String?,
        captainName: json['captainName'] as String?,
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'createdAt': createdAt?.toJson(),
        'captainId': captainId,
        'captainName': captainName,
        'note': note,
      };
}
