import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_captain/response/new_get_finance_daily_response.dart';

class NewCaptainFinanceDailyModel extends DataModel {
  int? id;
  int? captainProfileId;
  String? captainName;
  String? image;
  int? amountSum;
  int? toBePaid;

  NewCaptainFinanceDailyModel(this.id, this.captainName, this.captainProfileId,
      this.image, this.amountSum, this.toBePaid);

  List<NewCaptainFinanceDailyModel> _captainfinanceDaily = [];

  NewCaptainFinanceDailyModel.withData(
      CaptainFinanceDailyNewResponse response) {
    var data = response.data;

    data?.forEach((element) {
      _captainfinanceDaily.add(NewCaptainFinanceDailyModel(
          element.id,
          element.captainName,
          element.captainProfileId,
          element.image?.image ?? '',
          element.amountSum,
          element.toBePaid));
    });
  }
  List<NewCaptainFinanceDailyModel> get data => _captainfinanceDaily;
}
