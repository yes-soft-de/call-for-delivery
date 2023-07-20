// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_plan/response/my_profits_response/my_profits_response.dart';

class MyProfitsModel extends DataModel {
  late int ordersCountToday;
  late num profitToday;
  late int orderCountSinceLastPayment;
  late num netProfitSinceLastPayment;
  late num openOrderCost;

  /// must be 0
  late num firstSliceFromLimit;
  late num firstSliceToLimit;
  late num firstSliceCost;
  late num secondSliceFromLimit;
  late num secondSliceToLimit;
  late num secondSliceOneKilometerCost;
  late num thirdSliceFromLimit;
  late num thirdSliceToLimit;
  late num thirdSliceOneKilometerCost;
  late num unpaidAmountsFromCashToStores;
  late num profitsFromOrders;

  late MyProfitsModel _data;

  MyProfitsModel({
    required this.ordersCountToday,
    required this.profitToday,
    required this.orderCountSinceLastPayment,
    required this.netProfitSinceLastPayment,
    required this.openOrderCost,
    required this.firstSliceFromLimit,
    required this.firstSliceToLimit,
    required this.firstSliceCost,
    required this.secondSliceFromLimit,
    required this.secondSliceToLimit,
    required this.secondSliceOneKilometerCost,
    required this.thirdSliceFromLimit,
    required this.thirdSliceToLimit,
    required this.thirdSliceOneKilometerCost,
    required this.unpaidAmountsFromCashToStores,
    required this.profitsFromOrders,
  });

  MyProfitsModel.withData(MyProfitsResponse response) {
    var data = response.data;

    _data = MyProfitsModel(
      firstSliceCost: data?.firstSliceCost ?? _nullNumber,
      firstSliceFromLimit: 1,
      firstSliceToLimit: data?.firstSliceLimit ?? _nullNumber,
      openOrderCost: data?.openingOrderCost ?? _nullNumber,
      orderCountSinceLastPayment:
          (data?.sinceLastPaymentOrdersCount ?? _nullNumber).toInt(),
      ordersCountToday: data?.todayOrdersCount ?? _nullNumber.toInt(),
      profitToday: data?.todayFinancialAmount ?? _nullNumber,
      secondSliceFromLimit: data?.secondSliceFromLimit ?? _nullNumber,
      secondSliceOneKilometerCost:
          data?.secondSliceOneKilometerCost ?? _nullNumber,
      secondSliceToLimit: data?.secondSliceToLimit ?? _nullNumber,
      thirdSliceFromLimit: data?.thirdSliceFromLimit ?? _nullNumber,
      thirdSliceOneKilometerCost:
          data?.thirdSliceOneKilometerCost ?? _nullNumber,
      thirdSliceToLimit: data?.thirdSliceToLimit ?? _nullNumber,
      unpaidAmountsFromCashToStores:
          data?.sinceLastPaymentCashOrderAmount ?? _nullNumber,
      profitsFromOrders: data?.sinceLastPaymentFinancialAmount ?? _nullNumber,
      netProfitSinceLastPayment:
          data?.sinceLastPaymentRemainFinancialAmount ?? _nullNumber,
    );
  }

  num get _nullNumber => -1;

  MyProfitsModel get data => _data;
}
