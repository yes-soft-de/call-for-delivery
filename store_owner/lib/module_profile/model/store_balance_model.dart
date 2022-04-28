import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_profile/response/store_payments_response/datum.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class StoreBalanceModel extends DataModel {
  late List<PaymentModel> paymentsToStore;
  StoreBalanceModel({
    required this.paymentsToStore,
  });
  late StoreBalanceModel _model;
  StoreBalanceModel.withData(List<Datum> data) : super.withData() {
    var payments = <PaymentModel>[];
    data.forEach((e) {
      payments.add(PaymentModel(
          id: e.id ?? -1,
          amount: e.amount ?? 0,
          note: e.note,
          paymentDate: DateHelper.convert(e.date?.timestamp)));
    });
    _model = StoreBalanceModel(paymentsToStore: payments);
  }

  StoreBalanceModel get data => _model;
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
