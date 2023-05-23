import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_captain/response/captain_finance_daily_response.dart';

class CaptainFinanceDailyModel extends DataModel {
  int? id;
  String? captainName;
  String? image;
  dynamic captainFinancialDailyId;
  int? amount;
  int? alreadyHadAmount;
  int? financialSystemType;
  dynamic financialSystemPlan;
  int? isPaid;
  bool? withBonus;
  int? bonus;
  dynamic captainFinancialDailyUpdatedAt;
  CaptainFinanceDailyModel(
    this.id,
    this.captainName,
    this.image,
    this.captainFinancialDailyId,
    this.amount,
    this.alreadyHadAmount,
    this.financialSystemType,
    this.financialSystemPlan,
    this.isPaid,
    this.withBonus,
    this.bonus,
    this.captainFinancialDailyUpdatedAt,
  );

  List<CaptainFinanceDailyModel> _captainfinanceDaily = [];

  CaptainFinanceDailyModel.withData(CaptainFinanceDailyResponse response) {
    var data = response.data;

    data?.forEach((element) {
      _captainfinanceDaily.add(CaptainFinanceDailyModel(
          element.id,
          element.captainName,
          element.image?.image,
          element.captainFinancialDailyId,
          element.amount,
          element.alreadyHadAmount,
          element.financialSystemType,
          element.financialSystemPlan,
          element.isPaid,
          element.withBonus,
          element.bonus,
          captainFinancialDailyUpdatedAt));
    });
  }
  List<CaptainFinanceDailyModel> get data => _captainfinanceDaily;
}
