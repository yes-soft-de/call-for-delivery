import 'package:c4d/module_captain/response/captain_financial_dues_response/captain_financial_dues_response.dart';
import 'package:c4d/module_captain/response/captain_financial_dues_response/payments_from_company.dart';
import 'package:intl/intl.dart';

import 'package:c4d/abstracts/data_model/data_model.dart';

import 'package:c4d/utils/helpers/date_converter.dart';

class CaptainFinancialDuesModel extends DataModel {
  late int id;
  late num status;
  late num amount;
  late num amountForStore;
  late num statusAmountForStore;
  late String startDate;
  late String endDate;
  late List<PaymentModel> paymentsFromCompany;
  late Total total;

  List<CaptainFinancialDuesModel> _data = [];
  CaptainFinancialDuesModel({
    required this.id,
    required this.status,
    required this.amount,
    required this.amountForStore,
    required this.statusAmountForStore,
    required this.startDate,
    required this.endDate,
    required this.paymentsFromCompany,
    required this.total,
  });
  CaptainFinancialDuesModel.withData(CaptainFinancialDuesResponse response) {
    var datum = response.data;
    datum?.forEach((element) {
      _data.add(CaptainFinancialDuesModel(
          amount: element.amount ?? 0,
          amountForStore: element.amountForStore ?? 0,
          endDate: DateFormat.yMd()
              .format(DateHelper.convert(element.endDate?.timestamp)),
          id: element.id ?? -1,
          paymentsFromCompany: getPayments(element.paymentsFromCompany ?? []),
          startDate: DateFormat.yMd()
              .format(DateHelper.convert(element.startDate?.timestamp)),
          status: element.status ?? 0,
          statusAmountForStore: element.statusAmountForStore ?? 0,
          total: Total(
              advancePayment: element.total?.advancePayment,
              sumCaptainFinancialDues:
                  element.total?.sumCaptainFinancialDues ?? 0,
              sumPaymentsToCaptain: element.total?.sumPaymentsToCaptain ?? 0,
              total: element.total?.total ?? 0)));
    });
  }
  List<CaptainFinancialDuesModel> get data => _data;

  List<PaymentModel> getPayments(List<PaymentsFromCompany> p) {
    List<PaymentModel> payments = [];
    p.forEach((element) {
      payments.add(PaymentModel(
          note: element.note,
          amount: element.amount ?? 0,
          id: element.id ?? -1,
          paymentDate: DateHelper.convert(element.createdAt?.timestamp)));
    });
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

class Total {
  bool? advancePayment;
  num sumCaptainFinancialDues;
  num sumPaymentsToCaptain;
  num total;
  Total({
    required this.advancePayment,
    required this.sumCaptainFinancialDues,
    required this.sumPaymentsToCaptain,
    required this.total,
  });
}
