import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/response/orders_cash_finances_for_store_response/orders_cash_finances_for_store_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:intl/intl.dart';

class StoreCashOrdersFinanceModel extends DataModel {
  late Total total;
  late List<Order> orders;
  StoreCashOrdersFinanceModel({
    required this.total,
    required this.orders,
  });
  late StoreCashOrdersFinanceModel _data;
  StoreCashOrdersFinanceModel.withData(
      OrdersCashFinancesForStoreResponse response) {
    var data = response.data;
    Total _total = Total(
        advancePayment: data?.total?.advancePayment ?? false,
        sumAmountStorOwnerDues: data?.total?.sumAmountStorOwnerDues ?? 0,
        sumPaymentsFromCompany:
            num.tryParse(data?.total?.sumPaymentsFromCompany ?? '0') ?? 0,
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
          storeOwnerName: element.storeOwnerName ?? S.current.unknown,
          orderId: element.orderId ?? -1,
          amount: element.amount ?? 0,
          flag: element.flag ?? -1,
          createdAt: create,
          captainNote: element.captainNote,
          storeAmount: element.storeAmount ?? 0));
    });
    _data = StoreCashOrdersFinanceModel(total: _total, orders: _orders);
  }
  StoreCashOrdersFinanceModel get data => _data;
}

class Total {
  num sumAmountStorOwnerDues;
  num sumPaymentsFromCompany;
  bool advancePayment;
  num total;
  Total({
    required this.sumAmountStorOwnerDues,
    required this.sumPaymentsFromCompany,
    required this.advancePayment,
    required this.total,
  });
}

class Order {
  int id;
  String storeOwnerName;
  int orderId;
  num amount;
  int flag;
  String? captainNote;
  num storeAmount;
  String createdAt;
  Order(
      {required this.id,
      required this.storeOwnerName,
      required this.orderId,
      required this.amount,
      required this.flag,
      required this.createdAt,
      required this.storeAmount,
      required this.captainNote});
}
