import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_payments/response/captain_all_amounts.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class CaptainAllAmountModel extends DataModel {
  int? id;
  int? amount;
  String? note;
  DateTime? createdAt;

  CaptainAllAmountModel({this.id, this.amount, this.note, this.createdAt});

  List<CaptainAllAmountModel> _captainAllAmount = [];

  CaptainAllAmountModel.withData(CaptainAllFinanceResponse response) {
    var data = response.data;

    data?.forEach((element) {
      _captainAllAmount.add(CaptainAllAmountModel(
        id: element.id,
        amount: element.amount,
        note: element.note,
        createdAt: DateHelper.convert(element.createdAt?.timestamp),
      ));
    });
  }
  List<CaptainAllAmountModel> get data => _captainAllAmount;
}
