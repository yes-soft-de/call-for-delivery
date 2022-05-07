class Total {
  int? sumAmountStorOwnerDues;
  int? sumPaymentsFromCompany;
  bool? advancePayment;
  int? total;

  Total({
    this.sumAmountStorOwnerDues,
    this.sumPaymentsFromCompany,
    this.advancePayment,
    this.total,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        sumAmountStorOwnerDues: json['sumAmountStorOwnerDues'] as int?,
        sumPaymentsFromCompany: json['sumPaymentsFromCompany'] as int?,
        advancePayment: json['advancePayment'] as bool?,
        total: json['total'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'sumAmountStorOwnerDues': sumAmountStorOwnerDues,
        'sumPaymentsFromCompany': sumPaymentsFromCompany,
        'advancePayment': advancePayment,
        'total': total,
      };
}
