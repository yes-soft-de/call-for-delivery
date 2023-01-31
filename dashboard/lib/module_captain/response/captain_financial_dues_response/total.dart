class Total {
  int? advancePayment;
  num? sumCaptainFinancialDues;
  num? sumPaymentsToCaptain;
  num? total;

  Total({
    this.advancePayment,
    this.sumCaptainFinancialDues,
    this.sumPaymentsToCaptain,
    this.total,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        advancePayment: json['advancePayment'] as int?,
        sumCaptainFinancialDues: json['sumCaptainFinancialDues'] is String?
            ? num.tryParse(json['sumCaptainFinancialDues'] ?? '')
            : json['sumCaptainFinancialDues'] as num?,
        sumPaymentsToCaptain: json['sumPaymentsToCaptain'] is String?
            ? num.tryParse(json['sumPaymentsToCaptain'] ?? '')
            : json['sumPaymentsToCaptain'] as num?,
        total: json['total'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'advancePayment': advancePayment,
        'sumCaptainFinancialDues': sumCaptainFinancialDues,
        'sumPaymentsToCaptain': sumPaymentsToCaptain,
        'total': total,
      };
}
