import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_captain/response/new_get_finance_daily_response.dart';

class CaptainDuesModel extends DataModel {
  int? id;
  int? captainProfileId;
  String? captainName;
  String? image;
  num? amountSum;
  num? toBePaid;

  CaptainDuesModel(this.id, this.captainName, this.captainProfileId,
      this.image, this.amountSum, this.toBePaid);

  List<CaptainDuesModel> _captainfinanceDaily = [];

  CaptainDuesModel.withData(
      CaptainFinanceDailyNewResponse response) {
    var data = response.data;

    data?.forEach((element) {
      _captainfinanceDaily.add(CaptainDuesModel(
          element.id,
          element.captainName,
          element.captainProfileId,
          element.image?.image ?? '',
          element.amountSum,
          element.toBePaid));
    });
  }
  List<CaptainDuesModel> get data => _captainfinanceDaily;
}
