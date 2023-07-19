// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';

class MyProfitModel extends DataModel {
  late int ordersCountToday;
  late num profitToday;
  late int orderCountSinceLastPayment;
  late num profitSinceLastPayment;
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

  late MyProfitModel _data;

  MyProfitModel({
    required this.ordersCountToday,
    required this.profitToday,
    required this.orderCountSinceLastPayment,
    required this.profitSinceLastPayment,
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
  });

  MyProfitModel get data => _data;
}
