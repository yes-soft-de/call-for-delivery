class FinalFinancialAccount {
  num? financialDues;
  num? sumPayments;
  dynamic advancePayment;
  num? total;
  num? amountForStore;

  FinalFinancialAccount({
    this.financialDues,
    this.sumPayments,
    this.advancePayment,
    this.total,
    this.amountForStore,
  });

  factory FinalFinancialAccount.fromJson(Map<String, dynamic> json) {
    return FinalFinancialAccount(
      financialDues: json['financialDues'] as num?,
      amountForStore: json['amountForStore'] as num?,
      sumPayments: json['sumPayments'] as num?,
      advancePayment: json['advancePayment'] as dynamic,
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
