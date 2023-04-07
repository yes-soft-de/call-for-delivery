class FinalFinancialAccount {
  int? amountForStore;
  double? countOrdersWithoutDistance;
  double? financialDues;
  int? sumPayments;
  bool? advancePayment;
  double? total;
  String? dateFinancialCycleStarts;
  String? dateFinancialCycleEnds;

  FinalFinancialAccount({
    this.amountForStore,
    this.countOrdersWithoutDistance,
    this.financialDues,
    this.sumPayments,
    this.advancePayment,
    this.total,
    this.dateFinancialCycleStarts,
    this.dateFinancialCycleEnds,
  });

  factory FinalFinancialAccount.fromJson(Map<String, dynamic> json) {
    return FinalFinancialAccount(
      amountForStore: json['amountForStore'] as int?,
      countOrdersWithoutDistance:
          (json['countOrdersWithoutDistance'] as num?)?.toDouble(),
      financialDues: (json['financialDues'] as num?)?.toDouble(),
      sumPayments: json['sumPayments'] as int?,
      advancePayment: json['advancePayment'] as bool?,
      total: (json['total'] as num?)?.toDouble(),
      dateFinancialCycleStarts: json['dateFinancialCycleStarts'] as String?,
      dateFinancialCycleEnds: json['dateFinancialCycleEnds'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'amountForStore': amountForStore,
        'countOrdersWithoutDistance': countOrdersWithoutDistance,
        'financialDues': financialDues,
        'sumPayments': sumPayments,
        'advancePayment': advancePayment,
        'total': total,
        'dateFinancialCycleStarts': dateFinancialCycleStarts,
        'dateFinancialCycleEnds': dateFinancialCycleEnds,
      };
}
