import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/by_hour/by_hour_data.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/by_order/by_order_data.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/captain_account_balance_response.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/on_order/on_order_data.dart';

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
  List<OrderCountsSystemDetails>? orderCountsDetails;
  late num? amountForStore;
  late List<PaymentModel> paymentsToClient;
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
      required this.paymentsToClient,
      required this.ordersInMonth});
  late CaptainAccountBalanceModel _data;

  CaptainAccountBalanceModel.withData(CaptainAccountBalanceResponse response) {
    var element = response.data;

    if (element is OnOrderData?) {
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
            message: element.message));
      });

      _data = CaptainAccountBalanceModel(
        orderCountsDetails: details,
        advancePayment: element?.finalFinancialAccount?.advancePayment,
        compensationForEveryOrder: null,
        countOrders: null,
        countOrdersMaxFromNineteen: null,
        financialDues: element?.finalFinancialAccount?.financialDues,
        salary: null,
        sumPayments: element?.finalFinancialAccount?.sumPayments,
        total: element?.finalFinancialAccount?.total,
        bounce: null,
        countOrdersCompleted: null,
        countOverOrdersThanRequired: null,
        dateFinancialCycleEnds:
            element?.finalFinancialAccount?.dateFinancialCycleEnds,
        monthCompensation: null,
        monthTargetSuccess: null,
        amountForStore: element?.finalFinancialAccount?.amountForStore,
        paymentsToClient: getPayments(),
        ordersInMonth: null,
      );
    }
    if (element is ByHourData?) {
      _data = CaptainAccountBalanceModel(
        orderCountsDetails: null,
        advancePayment: element?.advancePayment,
        compensationForEveryOrder: element?.compensationForEveryOrder,
        countOrders: element?.countOrders,
        countOrdersMaxFromNineteen: element?.countOrdersMaxFromNineteen,
        financialDues: element?.financialDues,
        salary: element?.salary,
        sumPayments: element?.sumPayments,
        total: element?.total,
        bounce: null,
        countOrdersCompleted: null,
        countOverOrdersThanRequired: null,
        dateFinancialCycleEnds: element?.dateFinancialCycleEnds,
        monthCompensation: null,
        monthTargetSuccess: null,
        amountForStore: element?.amountForStore ?? 0,
        paymentsToClient: getPayments(),
        ordersInMonth: null,
      );
    }
    if (element is ByOrderData?) {
      _data = CaptainAccountBalanceModel(
          orderCountsDetails: null,
          advancePayment: element?.advancePayment != 0,
          compensationForEveryOrder: null,
          countOrders: null,
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
          monthTargetSuccess: element?.monthTargetSuccess,
          amountForStore: element?.amountForStore ?? 0,
          paymentsToClient: getPayments(),
          ordersInMonth: element?.countOrdersInMonth);
    }
  }

  CaptainAccountBalanceModel get data => _data;
  List<PaymentModel> getPayments() {
    List<PaymentModel> payments = [];

    return payments;
  }
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
  String? message;
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

class PaymentModel {
  int id;
  DateTime paymentDate;
  num amount;
  String? note;
  PaymentModel(
      {required this.id,
      required this.paymentDate,
      required this.amount,
      this.note});
}
