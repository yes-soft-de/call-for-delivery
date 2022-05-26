class Total {
  num? sumAmountWithCaptain;
  String? sumPaymentsToCaptain;
  bool? advancePayment;
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
        advancePayment: json['advancePayment'] as bool?,
        total: json['total'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'sumAmountWithCaptain': sumAmountWithCaptain,
        'sumPaymentsToCaptain': sumPaymentsToCaptain,
        'advancePayment': advancePayment,
        'total': total,
      };
}
