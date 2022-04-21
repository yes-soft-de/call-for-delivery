class FinalFinancialAccount {
  int? financialDues;
  int? sumPayments;
  bool? advancePayment;
  int? total;

  FinalFinancialAccount({
    this.financialDues,
    this.sumPayments,
    this.advancePayment,
    this.total,
  });

  factory FinalFinancialAccount.fromJson(Map<String, dynamic> json) {
    return FinalFinancialAccount(
      financialDues: json['financialDues'] as int?,
      sumPayments: json['sumPayments'] as int?,
      advancePayment: json['advancePayment'] as bool?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'financialDues': financialDues,
        'sumPayments': sumPayments,
        'advancePayment': advancePayment,
        'total': total,
      };
}
