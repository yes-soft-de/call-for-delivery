import 'payment.dart';

class Data {
  List<Payment>? payments;
  num? paymentsTotalAmount;
  num? toBePaid;

  Data({
    this.payments,
    this.paymentsTotalAmount,
    this.toBePaid,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        payments: (json['payments'] as List<dynamic>?)
            ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
            .toList(),
        paymentsTotalAmount: (json['paymentsTotalAmount'] as num?),
        toBePaid: (json['toBePaid'] as num?),
      );
}
