import 'package:c4d/module_plan/response/captain_account_balance_response/account_balance_data.dart';

class ByOrderData extends AccountBalanceData {
  int? salary;
  int? monthCompensation;
  int? countOverOrdersThanRequired;
  int? bounce;
  String? monthTargetSuccess;
  double? financialDues;
  double? total;
  double? countOrdersCompleted;
  String? dateFinancialCycleEnds;
  int? advancePayment;
  int? sumPayments;
  int? amountForStore;
  int? countOrdersInMonth;
  String? dateFinancialCycleStarts;
  int? countOrdersMaxFromNineteen;
  double? countOrdersWithoutDistance;

  ByOrderData({
    this.salary,
    this.monthCompensation,
    this.countOverOrdersThanRequired,
    this.bounce,
    this.monthTargetSuccess,
    this.financialDues,
    this.total,
    this.countOrdersCompleted,
    this.dateFinancialCycleEnds,
    this.advancePayment,
    this.sumPayments,
    this.amountForStore,
    this.countOrdersInMonth,
    this.dateFinancialCycleStarts,
    this.countOrdersMaxFromNineteen,
    this.countOrdersWithoutDistance,
  });

  factory ByOrderData.fromJson(Map<String, dynamic> json) => ByOrderData(
        salary: json['salary'] as int?,
        monthCompensation: json['monthCompensation'] as int?,
        countOverOrdersThanRequired:
            json['countOverOrdersThanRequired'] as int?,
        bounce: json['bounce'] as int?,
        monthTargetSuccess: json['monthTargetSuccess'] as String?,
        financialDues: (json['financialDues'] as num?)?.toDouble(),
        total: (json['total'] as num?)?.toDouble(),
        countOrdersCompleted:
            (json['countOrdersCompleted'] as num?)?.toDouble(),
        dateFinancialCycleEnds: json['dateFinancialCycleEnds'] as String?,
        advancePayment: json['advancePayment'] as int?,
        sumPayments: json['sumPayments'] as int?,
        amountForStore: json['amountForStore'] as int?,
        countOrdersInMonth: json['countOrdersInMonth'] as int?,
        dateFinancialCycleStarts: json['dateFinancialCycleStarts'] as String?,
        countOrdersMaxFromNineteen: json['countOrdersMaxFromNineteen'] as int?,
        countOrdersWithoutDistance:
            (json['countOrdersWithoutDistance'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'salary': salary,
        'monthCompensation': monthCompensation,
        'countOverOrdersThanRequired': countOverOrdersThanRequired,
        'bounce': bounce,
        'monthTargetSuccess': monthTargetSuccess,
        'financialDues': financialDues,
        'total': total,
        'countOrdersCompleted': countOrdersCompleted,
        'dateFinancialCycleEnds': dateFinancialCycleEnds,
        'advancePayment': advancePayment,
        'sumPayments': sumPayments,
        'amountForStore': amountForStore,
        'countOrdersInMonth': countOrdersInMonth,
        'dateFinancialCycleStarts': dateFinancialCycleStarts,
        'countOrdersMaxFromNineteen': countOrdersMaxFromNineteen,
        'countOrdersWithoutDistance': countOrdersWithoutDistance,
      };
}
