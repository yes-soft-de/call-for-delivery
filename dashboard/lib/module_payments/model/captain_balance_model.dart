import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_payments/response/captain_payments_response/datum.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class CaptainBalanceModel extends DataModel {
  late List<PaymentModel> paymentsToCaptain;
  CaptainBalanceModel({
    required this.paymentsToCaptain,
  });
  late CaptainBalanceModel _model;
  CaptainBalanceModel.withData(List<Datum> data) : super.withData() {
    var payments = <PaymentModel>[];
    data.forEach((e) {
      payments.add(PaymentModel(
          id: e.id?.toInt() ?? -1,
          amount: e.amount ?? 0,
          note: e.note,
          paymentDate: DateHelper.convert(e.createdAt?.timestamp)));
    });
    _model = CaptainBalanceModel(paymentsToCaptain: payments);
  }

  CaptainBalanceModel get data => _model;
}

class PaymentModel {
  int id;
  DateTime paymentDate;
  num amount;
  String? note;
  PaymentModel(
      {required this.id,
      required this.paymentDate,
      required this.amount,
      this.note});
}
