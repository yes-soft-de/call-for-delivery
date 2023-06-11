import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/response/captain_account_balance_response/captain_account_balance_response.dart';
import 'package:c4d/module_orders/response/orders_response/datum.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';

import '../../module_orders/model/order/order_model.dart';

class CaptainAccountBalanceModel extends DataModel {
  late num? countOrders;
  late num? countOrdersMaxFromNineteen;
  late num? compensationForEveryOrder;
  late num? salary;
  late num? financialDues;
  late num? sumPayments;
  late num? total;
  late dynamic advancePayment;
  late num? monthCompensation;
  late num? countOverOrdersThanRequired;
  late num? bounce;
  late num amountForStore;
  late String? monthTargetSuccess;
  late num? countOrdersCompleted;
  late String? dateFinancialCycleEnds;
  List<OrderCountsSystemDetails>? orderCountsDetails;
  late num? ordersInMonth;
  late List<OrderModel> orders;
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
      required this.ordersInMonth,
      required this.orders});
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
            message: element.message ?? '',
            orders: _getOrders(element.orders ?? [])));
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
          monthTargetSuccess: element?.monthTargetSuccess,
          amountForStore: element?.amountForStore ??
              element?.finalFinancialAccount?.amountForStore ??
              0,
          ordersInMonth: element?.countOrdersInMonth,
          orders: _getOrders(element?.orders ?? []));
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
          monthTargetSuccess: element?.monthTargetSuccess,
          amountForStore: element?.amountForStore ??
              element?.finalFinancialAccount?.amountForStore ??
              0,
          ordersInMonth: element?.countOrdersInMonth ?? 0,
          orders: _getOrders(element?.orders ?? []));
    }
  }
  CaptainAccountBalanceModel get data => _data;
  List<OrderModel> _getOrders(List<DatumOrder> o) {
    List<OrderModel> orders = [];
    o.forEach((element) {
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      // delivery date
      var delivery = DateFormat.jm()
              .format(DateHelper.convert(element.deliveryDate?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.deliveryDate?.timestamp));
      //
      orders.add(OrderModel(
        externalCompanyName: null,
        branchName: element.branchName ?? S.current.unknown,
        id: element.id ?? -1,
        createdDate: create,
        deliveryDate: delivery,
        note: element.note ?? '',
        orderCost: element.orderCost ?? 0,
        state: StatusHelper.getStatusEnum(element.state),
        storeName: element.storeOwnerName,
        orderIsMain: element.orderIsMain ?? false,
        subOrders: [],
        kilometer: 0,
        storeBranchToClientDistance: 0,
      ));
    });
    return orders;
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
  String message;
  List<OrderModel> orders;
  OrderCountsSystemDetails(
      {required this.categoryName,
      required this.countKilometersFrom,
      required this.countKilometersTo,
      required this.amount,
      required this.bounce,
      required this.bounceCountOrdersInMonth,
      required this.captainTotalCategory,
      required this.contOrderCompleted,
      required this.countOfOrdersLeft,
      required this.message,
      required this.orders});
}
