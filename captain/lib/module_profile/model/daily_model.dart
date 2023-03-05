import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_profile/response/daily_finance_response/daily_finance_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class DailyFinanceModel extends DataModel {
  num dailyTotal = 0;
  num totalProfit = 0;
  List<PaymentModel> payments = [];
  DailyFinanceModel({
    required this.dailyTotal,
    required this.totalProfit,
    required this.payments,
  });
  late DailyFinanceModel _model;
  DailyFinanceModel.withData(DailyFinanceResponse response) : super.withData() {
    var data = response.data;
    var payments = <PaymentModel>[];
    data?.captainPayments?.forEach((e) {
      payments.add(PaymentModel(
          id: e.id ?? -1,
          amount: e.amount ?? 0,
          note: e.note,
          paymentDate: DateHelper.convert(e.date?.timestamp)));
    });
    _model = DailyFinanceModel(
      totalProfit: data?.alreadyHadAmount ?? 0,
      dailyTotal: data?.amount ?? 0,
      payments: payments,
    );
  }
  DailyFinanceModel.empty();
  DailyFinanceModel get data => _model;
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
