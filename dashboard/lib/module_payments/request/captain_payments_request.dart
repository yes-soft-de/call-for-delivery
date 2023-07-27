class CaptainPaymentsRequest {
  int? captainId;
  num? amount;
  String? note;
  int? status;
  int? captainFinancialDuesId;
  String? fromDate;
  String? toDate;
  PaymentGetaway? paymentGetaway;
  PaymentType? paymentType;
  PaymentFor? paymentFor;

  CaptainPaymentsRequest({
    this.captainFinancialDuesId,
    this.status,
    this.captainId,
    this.amount,
    this.note,
    this.fromDate,
    this.toDate,
    this.paymentGetaway,
    this.paymentFor,
    this.paymentType,
  });

  CaptainPaymentsRequest.fromJson(dynamic json) {
    captainId = json['captainId'];
    amount = json['amount'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['captain'] = captainId;
    map['amount'] = amount;
    map['note'] = note;
    if (status != null) {
      map['status'] = status;
    }
    if (captainFinancialDuesId != null) {
      map['captainFinancialDuesId'] = captainFinancialDuesId;
    }
    if (fromDate != null) {
      map['fromDate'] = fromDate;
    }
    if (toDate != null) {
      map['toDate'] = toDate;
    }
    if (paymentGetaway != null) {
      map['paymentGetaway'] = paymentGetaway?.value;
    }
    if (paymentFor != null) {
      map['paymentFor'] = paymentFor?.value;
    }
    if (paymentType != null) {
      map['paymentType'] = paymentType?.value;
    }
    return map;
  }
}

enum PaymentGetaway {
  inAppPurchaseApple,
  inAppPurchaseGoogle,

  /// bank transfer
  tapPayment,
  manual,
  notSpecified;

  int get value {
    switch (this) {
      case PaymentGetaway.inAppPurchaseApple:
        return 225;
      case PaymentGetaway.inAppPurchaseGoogle:
        return 226;
      case PaymentGetaway.tapPayment:
        return 227;
      case PaymentGetaway.notSpecified:
        return 235;
      case PaymentGetaway.manual:
        return 236;
    }
  }
}

enum PaymentFor {
  captainDues,
  unifiedSubscription;

  int get value {
    switch (this) {
      case PaymentFor.captainDues:
        return 228;
      case PaymentFor.unifiedSubscription:
        return 229;
    }
  }
}

enum PaymentType {
  realPaymentByStore,
  realPaymentByAdmin,
  mockPaymentByStore,
  mockPaymentByAdmin,
  mockPaymentBySuperAdmin;

  int get value {
    switch (this) {
      case PaymentType.realPaymentByStore:
        return 229;
      case PaymentType.realPaymentByAdmin:
        return 230;
      case PaymentType.mockPaymentByStore:
        return 231;
      case PaymentType.mockPaymentByAdmin:
        return 232;
      case PaymentType.mockPaymentBySuperAdmin:
        return 233;
    }
  }
}
