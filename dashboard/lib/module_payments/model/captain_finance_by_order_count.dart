import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_payments/response/captain_finance_by_order_counts_response/captain_finance_by_order_counts_response.dart';

class CaptainFinanceByOrdersCountModel extends DataModel {
  late int id;
  late num countOrdersInMonth;
  late num salary;
  late num monthCompensation;
  late num bounceMaxCountOrdersInMonth;
  late num bounceMinCountOrdersInMonth;
  CaptainFinanceByOrdersCountModel({
    required this.id,
    required this.countOrdersInMonth,
    required this.monthCompensation,
    required this.bounceMaxCountOrdersInMonth,
    required this.salary,
    required this.bounceMinCountOrdersInMonth,
  });
  List<CaptainFinanceByOrdersCountModel> _data = [];
  CaptainFinanceByOrdersCountModel.withData(
      CaptainFinanceByOrderCountsResponse response) {
    var data = response.data;
    data?.forEach((element) {
      _data.add(CaptainFinanceByOrdersCountModel(
          id: element.id ?? -1,
          salary: element.salary ?? 0,
          bounceMaxCountOrdersInMonth: element.bounceMaxCountOrdersInMonth ?? 0,
          bounceMinCountOrdersInMonth: element.bounceMinCountOrdersInMonth ?? 0,
          countOrdersInMonth: element.countOrdersInMonth ?? 0,
          monthCompensation: element.monthCompensation ?? 0));
    });
  }
  List<CaptainFinanceByOrdersCountModel> get data => _data;
}
