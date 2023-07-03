import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentStatusRequest {
  /// 0 not paid, 1 paid success
  int status;

  /// 228 for welcome subscription
  /// 229 for standard (unified) subscription
  int? paymentFor;

  /// PAYMENT_GETAWAY_IN_APP_PURCHASE_APPLE_CONST = 225
  /// 
  /// PAYMENT_GETAWAY_IN_APP_PURCHASE_GOOGLE_CONST = 226
  /// 
  /// PAYMENT_GETAWAY_TAP_PAYMENT_CONST = 227
  /// 
  /// PAYMENT_GETAWAY_NOT_SPECIFIED_CONST = 235
  int? paymentGetaway;

  num? amount;

  /// id, token or key that related to the payment
  String? paymentId;

  /// optional
  String? clientAddress;

  /// for this app it will by 229 or 231
  /// 
  /// REAL_PAYMENT_BY_STORE_CONST = 229
  /// 
  /// REAL_PAYMENT_BY_ADMIN_CONST = 230
  /// 
  /// MOCK_PAYMENT_BY_STORE_CONST = 231
  /// 
  /// MOCK_PAYMENT_BY_ADMIN_CONST = 232
  /// 
  /// MOCK_PAYMENT_BY_SUPER_ADMIN_CONST = 233  
  int? paymentType;

  PaymentStatusRequest({
    required this.status,
    required this.paymentFor,
    required this.paymentGetaway,
    required this.amount,
     this.paymentId,
    required this.paymentType,
    this.clientAddress,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      if(paymentFor != null)
      'paymentFor': paymentFor,
      if(paymentGetaway != null)
      'paymentGetaway': paymentGetaway,
      if(amount != null)
      'amount': amount,
      if(paymentId != null)
      'paymentId': paymentId,
      if(clientAddress != null)
      'clientAddress': clientAddress,
      if(paymentType != null)
      'paymentType': paymentType,
    };
  }

  factory PaymentStatusRequest.fromMap(Map<String, dynamic> map) {
    return PaymentStatusRequest(
      status: (map['status'] ?? 0) as int,
      paymentFor: map['paymentFor'] != null ? map['paymentFor'] as int : null,
      paymentGetaway: map['paymentGetaway'] != null ? map['paymentGetaway'] as int : null,
      amount: map['amount'] != null ? map['amount'] as num : null,
      paymentId: map['paymentId'] != null ? map['paymentId'] as String : null,
      clientAddress: map['clientAddress'] != null ? map['clientAddress'] as String : null,
      paymentType: map['paymentType'] != null ? map['paymentType'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentStatusRequest.fromJson(String source) =>
      PaymentStatusRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  PaymentStatusRequest copyWith({
    int? status,
    int? paymentFor,
    int? paymentGetaway,
    num? amount,
    String? paymentId,
    String? clientAddress,
    int? paymentType,
  }) {
    return PaymentStatusRequest(
      status: status ?? this.status,
      paymentFor: paymentFor ?? this.paymentFor,
      paymentGetaway: paymentGetaway ?? this.paymentGetaway,
      amount: amount ?? this.amount,
      paymentId: paymentId ?? this.paymentId,
      clientAddress: clientAddress ?? this.clientAddress,
      paymentType: paymentType ?? this.paymentType,
    );
  }
}
