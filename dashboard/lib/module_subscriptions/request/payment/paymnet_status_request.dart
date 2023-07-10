// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentStatusRequest {

  int storeOwnerProfile;

  /// 0 not paid, 1 paid success
  PaymentStatus status;

  /// 228 for welcome subscription
  /// 229 for standard (unified) subscription
  PaymentFor? paymentFor;

  /// PAYMENT_GETAWAY_IN_APP_PURCHASE_APPLE_CONST = 225
  ///
  /// PAYMENT_GETAWAY_IN_APP_PURCHASE_GOOGLE_CONST = 226
  ///
  /// PAYMENT_GETAWAY_TAP_PAYMENT_CONST = 227
  ///
  /// PAYMENT_GETAWAY_NOT_SPECIFIED_CONST = 235
  ///
  /// PAYMENT_GETAWAY_MANUAL_CONST = 236
  PaymentGetaway? paymentGetaway;

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
  PaymentType? paymentType;

  PaymentStatusRequest({
    required this.storeOwnerProfile,
    required this.status,
    required this.paymentFor,
    required this.paymentGetaway,
    required this.amount,
    this.paymentId,
    this.clientAddress,
    required this.paymentType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storeOwnerProfile': storeOwnerProfile,
      'status': status.value,
      if (paymentFor != null) 'paymentFor': paymentFor!.value,
      if (paymentGetaway != null) 'paymentGetaway': paymentGetaway!.value,
      if (amount != null) 'amount': amount,
      if (paymentId != null) 'paymentId': paymentId,
      if (clientAddress != null) 'clientAddress': clientAddress,
      if (paymentType != null) 'paymentType': paymentType!.value,
    };
  }

  String toJson() => json.encode(toMap());
}

enum PaymentStatus {
  paidSuccess,
  notPaid;

  int get value {
    switch (this) {
      case PaymentStatus.paidSuccess:
        return 1;
      case PaymentStatus.notPaid:
        return 0;
    }
  }
}

enum PaymentFor {
  welcomeSubscription,
  unifiedSubscription;

  int get value {
    switch (this) {
      case PaymentFor.welcomeSubscription:
        return 228;
      case PaymentFor.unifiedSubscription:
        return 229;
    }
  }
}

enum PaymentGetaway {
  inAppPurchaseApple,
  inAppPurchaseGoogle,
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
