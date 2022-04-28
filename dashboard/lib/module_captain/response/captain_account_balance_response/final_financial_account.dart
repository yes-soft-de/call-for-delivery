class FinalFinancialAccount {
  num? financialDues;
  num? sumPayments;
  bool? advancePayment;
  num? total;

  FinalFinancialAccount({
    this.financialDues,
    this.sumPayments,
    this.advancePayment,
    this.total,
  });

  factory FinalFinancialAccount.fromJson(Map<String, dynamic> json) {
    return FinalFinancialAccount(
      financialDues: json['financialDues'] as num?,
      sumPayments: json['sumPayments'] as num?,
      advancePayment: json['advancePayment'] as bool?,
      total: json['total'] as num?,
    );
  }

  Map<String, dynamic> toJson() => {
        'financialDues': financialDues,
        'sumPayments': sumPayments,
        'advancePayment': advancePayment,
        'total': total,
      };
}
