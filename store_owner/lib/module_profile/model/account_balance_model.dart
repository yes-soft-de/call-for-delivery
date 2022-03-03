import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class AccountBalanceModel extends DataModel {
  num amountOwedToStore = 0;
  num sumPaymentsToStore = 0;
  num total = 0;
  List<PaymentsModel> payments = [];

  AccountBalanceModel? balanceModel;

  AccountBalanceModel(
      {required this.amountOwedToStore,
      required this.sumPaymentsToStore,
      required this.total,
      required this.payments});
  AccountBalanceModel.withData(data) : super.withData() {
    data.paymentsToStore!.forEach((v) {
      payments.add(PaymentsModel(
          date: DateHelper.convert(v.date?.timestamp),
          note: v.note ?? '',
          id: v.id ?? -1,
          amount: v.amount ?? 0));
    });
    balanceModel = AccountBalanceModel(
        amountOwedToStore: data.amountOwedToStore ?? 0,
        sumPaymentsToStore: data.sumPaymentsToStore ?? 0,
        total: data.total ?? 0,
        payments: payments);
  }
}

class PaymentsModel extends DataModel {
  int id = -1;
  num amount = 0;
  String note = '';
  DateTime date = DateTime.now();

  PaymentsModel? _model;

  PaymentsModel(
      {required this.id,
      required this.amount,
      required this.note,
      required this.date});
  PaymentsModel.withData(data) : super.withData() {
    _model = PaymentsModel(
        id: data.id ?? -1,
        amount: data.amount ?? -1,
        note: note,
        date: DateHelper.convert(data.date?.timestamp));
  }

  PaymentsModel get data {
    if (_model != null) {
      return _model!;
    } else {
      throw Exception('There is no data');
    }
  }
}
