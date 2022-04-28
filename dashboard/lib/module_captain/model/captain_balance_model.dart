import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_captain/response/captain_account_balance_response/captain_account_balance_response.dart';

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
  late num amountForStore;
  late String? monthTargetSuccess;
  late num? countOrdersCompleted;
  late String? dateFinancialCycleEnds;
  List<OrderCountsSystemDetails>? orderCountsDetails;
  late num? ordersInMonth;

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
      required this.monthTargetSuccess,
      this.orderCountsDetails,
      required this.amountForStore,
      required this.ordersInMonth
      });
  late CaptainAccountBalanceModel _data;
  CaptainAccountBalanceModel.withData(CaptainAccountBalanceResponse response) {
    var element = response.data;
    if (element?.finalFinancialAccount != null &&
        element?.financialAccountDetails != null) {
      var details = <OrderCountsSystemDetails>[];
      element?.financialAccountDetails?.forEach((element) {
        details.add(OrderCountsSystemDetails(
            amount: element.amount ?? 0,
            bounce: element.bounce ?? 0,
            bounceCountOrdersInMonth: element.bounceCountOrdersInMonth ?? 0,
            captainTotalCategory: element.captainTotalCategory ?? 0,
            categoryName: element.categoryName ?? '',
            contOrderCompleted: element.contOrderCompleted ?? 0,
            countKilometersFrom: element.countKilometersFrom ?? 0,
            countKilometersTo: element.countKilometersTo ?? 0,
            countOfOrdersLeft: element.countOfOrdersLeft ?? 0,
            message: element.message ?? ''));
      });
      _data = CaptainAccountBalanceModel(
          orderCountsDetails: details,
          advancePayment: element?.finalFinancialAccount?.advancePayment,
          compensationForEveryOrder: element?.compensationForEveryOrder,
          countOrders: element?.countOrders,
          countOrdersMaxFromNineteen: element?.countOrdersMaxFromNineteen,
          financialDues: element?.finalFinancialAccount?.financialDues,
          salary: element?.salary,
          sumPayments: element?.finalFinancialAccount?.sumPayments,
          total: element?.finalFinancialAccount?.total,
          bounce: element?.bounce,
          countOrdersCompleted: element?.countOrdersCompleted,
          countOverOrdersThanRequired: element?.countOverOrdersThanRequired,
          dateFinancialCycleEnds: element?.dateFinancialCycleEnds,
          monthCompensation: element?.monthCompensation,
          monthTargetSuccess: element?.monthTargetSuccess, amountForStore: element?.amountForStore ?? 0, ordersInMonth: element?.countOrdersInMonth);
    } else {
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
          monthTargetSuccess: element?.monthTargetSuccess, amountForStore: element?.amountForStore ?? 0, 
          ordersInMonth: element?.countOrdersInMonth ?? 0);
    }
  }
  CaptainAccountBalanceModel get data => _data;
}

class OrderCountsSystemDetails {
  String categoryName;
  num countKilometersFrom;
  num countKilometersTo;
  num amount;
  num bounce;
  num bounceCountOrdersInMonth;
  num captainTotalCategory;
  num contOrderCompleted;
  num countOfOrdersLeft;
  String message;
  OrderCountsSystemDetails({
    required this.categoryName,
    required this.countKilometersFrom,
    required this.countKilometersTo,
    required this.amount,
    required this.bounce,
    required this.bounceCountOrdersInMonth,
    required this.captainTotalCategory,
    required this.contOrderCompleted,
    required this.countOfOrdersLeft,
    required this.message,
  });
}
