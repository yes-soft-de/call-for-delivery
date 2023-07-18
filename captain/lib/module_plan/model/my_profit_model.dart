// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';

class MyProfitModel extends DataModel {
  late int ordersCountToday;
  late num profitToday;
  late int orderCountSinceLastPayment;
  late num profitSinceLastPayment;

  late MyProfitModel _data;

  MyProfitModel({
    required this.ordersCountToday,
    required this.profitToday,
    required this.orderCountSinceLastPayment,
    required this.profitSinceLastPayment,
  });

  MyProfitModel get data => _data;
}
