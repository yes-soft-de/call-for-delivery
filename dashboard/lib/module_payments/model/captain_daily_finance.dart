import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_payments/response/captain_dialy_finance/captain_dialy_finance.dart';
import 'package:c4d/module_payments/response/captain_dialy_finance/captain_payment.dart';
import 'package:c4d/utils/helpers/date_converter.dart';


class CaptainDailyFinanceModel extends DataModel {
  late int id;
  late num amount;
  late num alreadyHadAmount;
  late int financialSystemType;
  late int financialSystemPlan;
  late int isPaid;
  late bool withBonus;
  late num bonus;
  late DateTime createdAt;
  late DateTime updateTime;
  List<PaymentModel> payments = [];
  CaptainDailyFinanceModel({
    required this.id,
    required this.amount,
    required this.alreadyHadAmount,
    required this.financialSystemType,
    required this.financialSystemPlan,
    required this.isPaid,
    required this.bonus,
    required this.createdAt,
    required this.payments,
    required this.updateTime,
    required this.withBonus,
  });
  List<CaptainDailyFinanceModel> _data = [];
  CaptainDailyFinanceModel.withData(CaptainDailyFinanceResponse response) {
    var d = response.data ?? [];
    for (var e in d) {
      _data.add(CaptainDailyFinanceModel(
        id: e.id ?? -1,
        alreadyHadAmount: e.alreadyHadAmount ?? 0,
        amount: e.amount ?? 0,
        bonus: e.bonus ?? 0,
        createdAt: DateHelper.convert(e.createdAt?.timestamp),
        financialSystemPlan: e.financialSystemPlan ?? 0,
        financialSystemType: e.financialSystemType ?? 0,
        isPaid: e.isPaid ?? 0,
        payments: getPayments(e.captainPayments ?? []),
        updateTime: DateHelper.convert(e.updatedAt?.timestamp),
        withBonus: e.withBonus ?? false,
      ));
    }
  }
  List<CaptainDailyFinanceModel> get data => _data;
  List<PaymentModel> getPayments(List<CaptainPayment> p) {
    List<PaymentModel> payments = [];
    for (var pp in p) {
      payments.add(PaymentModel(
          amount: pp.amount ?? 0,
          id: pp.id ?? -1,
          note: pp.note,
          paymentDate: DateHelper.convert(pp.createdAt?.timestamp)));
    }
    return payments;
  }
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
