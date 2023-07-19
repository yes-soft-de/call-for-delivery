import 'payment.dart';

class Data {
  List<Payment>? payments;
  int? paymentsTotalAmount;

  Data({this.payments, this.paymentsTotalAmount});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        payments: (json['payments'] as List<dynamic>?)
            ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
            .toList(),
        paymentsTotalAmount: json['paymentsTotalAmount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'payments': payments?.map((e) => e.toJson()).toList(),
        'paymentsTotalAmount': paymentsTotalAmount,
      };
}
