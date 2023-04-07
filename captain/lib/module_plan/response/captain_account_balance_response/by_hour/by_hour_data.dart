import 'package:c4d/module_plan/response/captain_account_balance_response/account_balance_data.dart';

class ByHourData extends AccountBalanceData {
  double? countOrders;
  int? countOrdersMaxFromNineteen;
  int? compensationForEveryOrder;
  int? salary;
  int? financialDues;
  int? sumPayments;
  int? total;
  bool? advancePayment;
  int? amountForStore;
  String? dateFinancialCycleStarts;
  String? dateFinancialCycleEnds;
  double? countOrdersWithoutDistance;

  ByHourData({
    this.countOrders,
    this.countOrdersMaxFromNineteen,
    this.compensationForEveryOrder,
    this.salary,
    this.financialDues,
    this.sumPayments,
    this.total,
    this.advancePayment,
    this.amountForStore,
    this.dateFinancialCycleStarts,
    this.dateFinancialCycleEnds,
    this.countOrdersWithoutDistance,
  });

  factory ByHourData.fromJson(Map<String, dynamic> json) => ByHourData(
        countOrders: (json['countOrders'] as num?)?.toDouble(),
        countOrdersMaxFromNineteen: json['countOrdersMaxFromNineteen'] as int?,
        compensationForEveryOrder: json['compensationForEveryOrder'] as int?,
        salary: json['salary'] as int?,
        financialDues: json['financialDues'] as int?,
        sumPayments: json['sumPayments'] as int?,
        total: json['total'] as int?,
        advancePayment: json['advancePayment'] as bool?,
        amountForStore: json['amountForStore'] as int?,
        dateFinancialCycleStarts: json['dateFinancialCycleStarts'] as String?,
        dateFinancialCycleEnds: json['dateFinancialCycleEnds'] as String?,
        countOrdersWithoutDistance:
            (json['countOrdersWithoutDistance'] as num?)?.toDouble(),
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
        'amountForStore': amountForStore,
        'dateFinancialCycleStarts': dateFinancialCycleStarts,
        'dateFinancialCycleEnds': dateFinancialCycleEnds,
        'countOrdersWithoutDistance': countOrdersWithoutDistance,
      };
}
