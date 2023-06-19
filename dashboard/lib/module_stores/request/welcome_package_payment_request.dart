class WelcomePackagePaymentRequest {
  int id;
  bool openingSubscriptionWithoutPayment;

  WelcomePackagePaymentRequest({
    required this.id,
    required this.openingSubscriptionWithoutPayment,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['openingSubscriptionWithoutPayment'] = openingSubscriptionWithoutPayment;

    return map;
  }
}
