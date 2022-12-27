import 'finished_payment.dart';

class PaymentCashResponse {
  List<FinishedPayment>? finishedPayments;

  PaymentCashResponse({this.finishedPayments});

  factory PaymentCashResponse.fromJson(Map<String, dynamic> json) {
    return PaymentCashResponse(
      finishedPayments: (json['finishedPayments'] as List<dynamic>?)
          ?.map((e) => FinishedPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'finishedPayments': finishedPayments?.map((e) => e.toJson()).toList(),
      };
}
