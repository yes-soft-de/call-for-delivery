import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_payments/response/captain_finance_by_hours_response/captain_finance_by_hours_response.dart';

class CaptainFinanceByHoursModel extends DataModel {
  late int id;
  late int countHours;
  late num compensationForEveryOrder;
  late num salary;
  CaptainFinanceByHoursModel({
    required this.id,
    required this.countHours,
    required this.compensationForEveryOrder,
    required this.salary,
  });
  List<CaptainFinanceByHoursModel> _data = [];
  CaptainFinanceByHoursModel.withData(CaptainFinanceByHoursResponse response) {
    var data = response.data;
    data?.forEach((element) {
      _data.add(CaptainFinanceByHoursModel(
          id: element.id ?? -1,
          compensationForEveryOrder: element.compensationForEveryOrder ?? 0,
          countHours: element.countHours ?? 0,
          salary: element.salary ?? 0));
    });
  }
  List<CaptainFinanceByHoursModel> get data => _data;
}
