class Total {
  num? sumAmountStorOwnerDues;
  String? sumPaymentsFromCompany;
  bool? advancePayment;
  num? total;

  Total({
    this.sumAmountStorOwnerDues,
    this.sumPaymentsFromCompany,
    this.advancePayment,
    this.total,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        sumAmountStorOwnerDues: json['sumAmountStorOwnerDues'] as num?,
        sumPaymentsFromCompany: json['sumPaymentsFromCompany']?.toString(),
        advancePayment: json['advancePayment'] as bool?,
        total: json['total'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'sumAmountStorOwnerDues': sumAmountStorOwnerDues,
        'sumPaymentsFromCompany': sumPaymentsFromCompany,
        'advancePayment': advancePayment,
        'total': total,
      };
}
