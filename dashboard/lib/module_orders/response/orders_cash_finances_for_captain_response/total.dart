class Total {
  int? sumAmountWithCaptain;
  dynamic sumPaymentsToCaptain;
  bool? advancePayment;
  int? total;

  Total({
    this.sumAmountWithCaptain,
    this.sumPaymentsToCaptain,
    this.advancePayment,
    this.total,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        sumAmountWithCaptain: json['sumAmountWithCaptain'] as int?,
        sumPaymentsToCaptain: json['sumPaymentsToCaptain'] as dynamic,
        advancePayment: json['advancePayment'] as bool?,
        total: json['total'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'sumAmountWithCaptain': sumAmountWithCaptain,
        'sumPaymentsToCaptain': sumPaymentsToCaptain,
        'advancePayment': advancePayment,
        'total': total,
      };
}
