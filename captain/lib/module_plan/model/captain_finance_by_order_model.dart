import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/response/captain_financeby_order_response/captain_financeby_order_response.dart';
class CaptainFinanceByOrderModel extends DataModel {
  late int id;
  late String categoryName;
  late num countKilometersFrom;
  late num countKilometersTo;
  late num amount;
  late num bounce;
  late num bounceCountOrdersInMonth;
  CaptainFinanceByOrderModel({
    required this.id,
    required this.categoryName,
    required this.countKilometersFrom,
    required this.countKilometersTo,
    required this.amount,
    required this.bounce,
    required this.bounceCountOrdersInMonth,
  });
  List<CaptainFinanceByOrderModel> _data = [];
  CaptainFinanceByOrderModel.withData(CaptainFinanceByOrderResponse response) {
    var data = response.data;
    data?.forEach((element) {
      _data.add(CaptainFinanceByOrderModel(
          amount: element.amount ?? 0,
          bounce: element.bounce ?? 0,
          bounceCountOrdersInMonth: element.bounceCountOrdersInMonth ?? 0,
          categoryName: element.categoryName ?? S.current.unknown,
          countKilometersFrom: element.countKilometersFrom ?? 0,
          countKilometersTo: element.countKilometersTo ?? 0,
          id: element.id ?? -1));
    });
  }
  List<CaptainFinanceByOrderModel> get data => _data;
}
