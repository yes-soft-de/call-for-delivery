import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_profile/response/daily_finaince_response.dart';

class DailyFinanceModel extends DataModel {
  num dailyTotal = 0;
  num totalProfit = 0;
  DailyFinanceModel({
    required this.dailyTotal,
    required this.totalProfit,
  });
  late DailyFinanceModel _model;
  DailyFinanceModel.withData(Finance data) : super.withData() {
    _model = DailyFinanceModel(
      totalProfit: data.totalAmount ?? 0,
      dailyTotal: data.dailyTotal ?? 0,
    );
  }
  DailyFinanceModel.empty();
  DailyFinanceModel get data => _model;
}
