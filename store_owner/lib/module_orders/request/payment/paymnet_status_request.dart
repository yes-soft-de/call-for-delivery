import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentStatusRequest {
  /// 0 not paid, 1 paid success
  int status;

  /// currently we only have payment for subscriptions so the value only can be 228
  int? paymentFor;

  /// PAYMENT_GETAWAY_IN_APP_PURCHASE_APPLE_CONST = 225
  /// PAYMENT_GETAWAY_IN_APP_PURCHASE_GOOGLE_CONST = 226
  /// PAYMENT_GETAWAY_TAP_PAYMENT_CONST = 227
  int? paymentGetaway;

  int? amount;

  /// id, token or key that related to the payment
  int? paymentId;

  /// optional
  int? clientAddress;

  PaymentStatusRequest({
    required this.status,
    this.paymentFor = 228,
    this.paymentGetaway,
    this.amount,
    this.paymentId,
    this.clientAddress,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'paymentFor': paymentFor,
      'paymentGetaway': paymentGetaway,
      'amount': amount,
      'paymentId': paymentId,
      'clientAddress': clientAddress,
    };
  }

  factory PaymentStatusRequest.fromMap(Map<String, dynamic> map) {
    return PaymentStatusRequest(
      status: (map['status'] ?? 0) as int,
      paymentFor: map['paymentFor'] != null ? map['paymentFor'] as int : null,
      paymentGetaway: map['paymentGetaway'] != null ? map['paymentGetaway'] as int : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
      paymentId: map['paymentId'] != null ? map['paymentId'] as int : null,
      clientAddress: map['clientAddress'] != null ? map['clientAddress'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentStatusRequest.fromJson(String source) =>
      PaymentStatusRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  PaymentStatusRequest copyWith({
    int? status,
    int? paymentFor,
    int? paymentGetaway,
    int? amount,
    int? paymentId,
    int? clientAddress,
  }) {
    return PaymentStatusRequest(
      status: status ?? this.status,
      paymentFor: paymentFor ?? this.paymentFor,
      paymentGetaway: paymentGetaway ?? this.paymentGetaway,
      amount: amount ?? this.amount,
      paymentId: paymentId ?? this.paymentId,
      clientAddress: clientAddress ?? this.clientAddress,
    );
  }
}
