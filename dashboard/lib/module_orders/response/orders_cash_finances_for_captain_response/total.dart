class Total {
  num? sumAmountWithCaptain;
  String? sumPaymentsToCaptain;
  dynamic advancePayment;
  num? total;

  Total({
    this.sumAmountWithCaptain,
    this.sumPaymentsToCaptain,
    this.advancePayment,
    this.total,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        sumAmountWithCaptain: json['sumAmountWithCaptain'] as num?,
        sumPaymentsToCaptain: json['sumPaymentsToCaptain']?.toString(),
        advancePayment: json['advancePayment'] as dynamic,
        total: json['total'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'sumAmountWithCaptain': sumAmountWithCaptain,
        'sumPaymentsToCaptain': sumPaymentsToCaptain,
        'advancePayment': advancePayment,
        'total': total,
      };
}
