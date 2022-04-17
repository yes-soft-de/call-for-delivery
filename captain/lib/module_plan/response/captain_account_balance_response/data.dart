class Data {
  num? countOrders;
  num? countOrdersMaxFromNineteen;
  num? compensationForEveryOrder;
  num? salary;
  num? financialDues;
  num? sumPayments;
  num? total;
  bool? advancePayment;
  num? monthCompensation;
  num? countOverOrdersThanRequired;
  num? bounce;
  String? monthTargetSuccess;
  num? countOrdersCompleted;
  String? dateFinancialCycleEnds;

  Data(
      {this.countOrders,
      this.countOrdersMaxFromNineteen,
      this.compensationForEveryOrder,
      this.salary,
      this.financialDues,
      this.sumPayments,
      this.total,
      this.advancePayment,
      this.bounce,
      this.countOrdersCompleted,
      this.countOverOrdersThanRequired,
      this.dateFinancialCycleEnds,
      this.monthCompensation,
      this.monthTargetSuccess});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        countOrders: json['countOrders'] as num?,
        countOrdersMaxFromNineteen: json['countOrdersMaxFromNineteen'] as num?,
        compensationForEveryOrder: json['compensationForEveryOrder'] as num?,
        salary: json['salary'] as num?,
        financialDues: json['financialDues'] as num?,
        sumPayments: json['sumPayments'] as num?,
        total: json['total'] as num?,
        advancePayment: json['advancePayment'] as bool?,
        bounce: json['bounce'] as num?,
        countOrdersCompleted: json['countOrdersCompleted'] as num?,
        countOverOrdersThanRequired:
            json['countOverOrdersThanRequired'] as num?,
        dateFinancialCycleEnds: json['dateFinancialCycleEnds'] as String?,
        monthCompensation: json['monthCompensation'] as num?,
        monthTargetSuccess: json['monthTargetSuccess'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'countOrders': countOrders,
        'countOrdersMaxFromNineteen': countOrdersMaxFromNineteen,
        'compensationForEveryOrder': compensationForEveryOrder,
        'salary': salary,
        'financialDues': financialDues,
        'sumPayments': sumPayments,
        'total': total,
        'advancePayment': advancePayment,
      };
}
