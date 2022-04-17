import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/captain_account_balance_response.dart';

class CaptainAccountBalanceModel extends DataModel {
  late num? countOrders;
  late num? countOrdersMaxFromNineteen;
  late num? compensationForEveryOrder;
  late num? salary;
  late num? financialDues;
  late num? sumPayments;
  late num? total;
  late bool? advancePayment;
  late num? monthCompensation;
  late num? countOverOrdersThanRequired;
  late num? bounce;
  late String? monthTargetSuccess;
  late num? countOrdersCompleted;
  late String? dateFinancialCycleEnds;
  CaptainAccountBalanceModel(
      {required this.advancePayment,
      required this.compensationForEveryOrder,
      required this.countOrders,
      required this.countOrdersMaxFromNineteen,
      required this.financialDues,
      required this.salary,
      required this.sumPayments,
      required this.total,
      required this.monthCompensation,
      required this.bounce,
      required this.countOrdersCompleted,
      required this.countOverOrdersThanRequired,
      required this.dateFinancialCycleEnds,
      required this.monthTargetSuccess});
  late CaptainAccountBalanceModel _data;
  CaptainAccountBalanceModel.withData(CaptainAccountBalanceResponse response) {
    var element = response.data;
    _data = CaptainAccountBalanceModel(
        advancePayment: element?.advancePayment,
        compensationForEveryOrder: element?.compensationForEveryOrder,
        countOrders: element?.countOrders,
        countOrdersMaxFromNineteen: element?.countOrdersMaxFromNineteen,
        financialDues: element?.financialDues,
        salary: element?.salary,
        sumPayments: element?.sumPayments,
        total: element?.total,
        bounce: element?.bounce,
        countOrdersCompleted: element?.countOrdersCompleted,
        countOverOrdersThanRequired: element?.countOverOrdersThanRequired,
        dateFinancialCycleEnds: element?.dateFinancialCycleEnds,
        monthCompensation: element?.monthCompensation,
        monthTargetSuccess: element?.monthTargetSuccess);
  }
  CaptainAccountBalanceModel get data => _data;
}
