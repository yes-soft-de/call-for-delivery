import 'package:c4d/utils/helpers/date_converter.dart';

class EPayment {
  int? id;
  int? paymentGetaway;
  num? amount;
  int? paymentFor;
  String? details;
  DateTime? createdAt;
  int? paymentType;
  int? createdBy;

  EPayment({
    this.id,
    this.paymentGetaway,
    this.amount,
    this.paymentFor,
    this.details,
    this.createdAt,
    this.paymentType,
    this.createdBy,
  });

  factory EPayment.fromJson(Map<String, dynamic> json) => EPayment(
        id: json['id'] as int?,
        paymentGetaway: json['paymentGetaway'] as int?,
        amount: json['amount'] as num?,
        paymentFor: json['paymentFor'] as int?,
        details: json['details'] as String?,
        createdAt: DateHelper.convert(json['createdAt']['timestamp'] as int?),
        paymentType: json['paymentType'] as int?,
        createdBy: json['createdBy'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'paymentGetaway': paymentGetaway,
        'amount': amount,
        'paymentFor': paymentFor,
        'details': details,
        'paymentType': paymentType,
        'createdBy': createdBy,
      };
}
