import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_stores/response/store_balance_response/data.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class StoreBalanceModel extends DataModel {
  late num amountOwedToStore;
  late num sumPaymentsToStore;
  late num total;
  late List<PaymentModel> paymentsToStore;
  StoreBalanceModel({
    required this.amountOwedToStore,
    required this.sumPaymentsToStore,
    required this.total,
    required this.paymentsToStore,
  });
  late StoreBalanceModel _model;
  StoreBalanceModel.withData(Data data) : super.withData() {
    var payments = <PaymentModel>[];
    data.paymentsToStore?.forEach((e) {
      payments.add(PaymentModel(
          id: e.id ?? -1,
          amount: e.amount ?? 0,
          note: e.note,
          paymentDate: DateHelper.convert(e.date?.timestamp)));
    });
    _model = StoreBalanceModel(
        amountOwedToStore: data.amountOwedToStore ?? 0,
        paymentsToStore: payments,
        sumPaymentsToStore: data.sumPaymentsToStore ?? 0,
        total: data.total ?? 0);
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
