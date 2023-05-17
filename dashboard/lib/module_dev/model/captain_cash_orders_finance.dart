import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/response/orders_cash_finances_for_captain_response/orders_cash_finances_for_captain_response.dart';
import 'package:c4d/module_orders/response/orders_cash_finances_for_captain_response/payment_cash_response/finished_payment.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:intl/intl.dart';

class CaptainCashOrdersFinanceModel extends DataModel {
  late Total total;
  late List<Order> orders;
  late List<FinishedPayment> finishedPayment;
  CaptainCashOrdersFinanceModel(
      {required this.total,
      required this.orders,
      required this.finishedPayment});
  late CaptainCashOrdersFinanceModel _data;
  CaptainCashOrdersFinanceModel.withData(
      OrdersCashFinancesForCaptainResponse response) {
    var data = response.data;
    Total _total = Total(
        advancePayment: data?.total?.advancePayment,
        sumAmountWithCaptain: data?.total?.sumAmountWithCaptain ?? 0,
        sumPaymentsToCaptain:
            num.tryParse(data?.total?.sumPaymentsToCaptain ?? '0') ?? 0,
        total: data?.total?.total ?? 0);
    var _orders = <Order>[];
    response.data?.detail?.forEach((element) {
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      _orders.add(Order(
          id: element.id ?? 0,
          captainName: element.captainName ?? S.current.unknown,
          orderId: element.orderId ?? -1,
          amount: element.amount ?? 0,
          flag: element.flag ?? -1,
          createdAt: create,
          captainNote: element.captainNote,
          storeAmount: element.storeAmount ?? 0));
    });
    _data = CaptainCashOrdersFinanceModel(
        total: _total, orders: _orders, finishedPayment: data?.payments ?? []);
  }
  CaptainCashOrdersFinanceModel get data => _data;
}

class Total {
  num sumAmountWithCaptain;
  num sumPaymentsToCaptain;
  dynamic advancePayment;
  num total;
  Total({
    required this.sumAmountWithCaptain,
    required this.sumPaymentsToCaptain,
    required this.advancePayment,
    required this.total,
  });
}

class Order {
  int id;
  String captainName;
  int orderId;
  num amount;
  int flag;
  String createdAt;
  String? captainNote;
  num storeAmount;
  Order(
      {required this.id,
      required this.captainName,
      required this.orderId,
      required this.amount,
      required this.flag,
      required this.createdAt,
      required this.captainNote,
      required this.storeAmount});
}
