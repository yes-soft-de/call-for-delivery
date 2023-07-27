// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_payments/response/captain_finance_response/captain_finance_response.dart';

class CaptainPaymentModel extends DataModel {
  late int captainFinancialDuesId;
  late num duesSinceLastPayment;
  late num unpaidAmountsFromCashToStores;
  late num profitsFromOrders;
  late num lastPayment;
  late DateTime lastPaymentDate;

  late CaptainPaymentModel _data;

  CaptainPaymentModel({
    required this.captainFinancialDuesId,
    required this.duesSinceLastPayment,
    required this.unpaidAmountsFromCashToStores,
    required this.profitsFromOrders,
    required this.lastPayment,
    required this.lastPaymentDate,
  });

  CaptainPaymentModel.withData(CaptainFinanceResponse response) {
    var data = response.data;

    _data = CaptainPaymentModel(
      captainFinancialDuesId: data?.id ?? _nullNumber,
      duesSinceLastPayment: data?.finalAmount ?? _nullNumber,
      lastPayment: data?.lastPaymentAmount ?? _nullNumber,
      lastPaymentDate: data?.lastPaymentDate ?? DateTime.now(),
      profitsFromOrders: data?.amount ?? _nullNumber,
      unpaidAmountsFromCashToStores: data?.amountForStore ?? _nullNumber,
    );
  }

  int _nullNumber = 0;
  CaptainPaymentModel get data => _data;
}
