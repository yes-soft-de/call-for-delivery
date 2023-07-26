import 'e_payment.dart';

class Data {
  num? subscriptionCost;
  List<EPayment>? ePayments;
  bool? hasToPay;

  Data({
    this.subscriptionCost,
    this.ePayments,
    this.hasToPay,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      subscriptionCost: json['subscriptionCost'] as num?,
      ePayments: (json['ePayments'] as List<dynamic>?)
          ?.map((e) => EPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasToPay: json['hasToPay'] as bool?);
}
