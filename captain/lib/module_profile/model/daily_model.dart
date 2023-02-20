import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_profile/response/daily_finance_response/daily_finance_response.dart';

class DailyFinanceModel extends DataModel {
  num dailyTotal = 0;
  num totalProfit = 0;
  DailyFinanceModel({
    required this.dailyTotal,
    required this.totalProfit,
  });
  late DailyFinanceModel _model;
  DailyFinanceModel.withData(DailyFinanceResponse response) : super.withData() {
    var data = response.data;
    _model = DailyFinanceModel(
      totalProfit: data?.alreadyHadAmount ?? 0,
      dailyTotal: data?.amount ?? 0,
    );
  }
  DailyFinanceModel.empty();
  DailyFinanceModel get data => _model;
}
