import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/response/subscriptions_financial_response/captain_offer.dart';
import 'package:c4d/module_stores/response/subscriptions_financial_response/payments_from_company.dart';
import 'package:c4d/module_stores/response/subscriptions_financial_response/subscriptions_financial_response.dart';
import 'package:intl/intl.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class StoreSubscriptionsFinanceModel extends DataModel {
  late int id;
  late String packageName;
  late String status;
  late String? note;
  dynamic flag;
  late String startDate;
  late String endDate;
  late List<PaymentModel> paymentsFromStore;
  late Total total;
  late List<CaptainOffer> captainsOffer;

  List<StoreSubscriptionsFinanceModel> _data = [];
  StoreSubscriptionsFinanceModel({
    required this.id,
    required this.status,
    required this.packageName,
    required this.flag,
    required this.note,
    required this.startDate,
    required this.endDate,
    required this.paymentsFromStore,
    required this.total,
    required this.captainsOffer
  });
  StoreSubscriptionsFinanceModel.withData(
      SubscriptionsFinancialResponse response) {
    var datum = response.data;
    datum?.forEach((element) {
      _data.add(StoreSubscriptionsFinanceModel(
          endDate: DateFormat.yMd()
              .format(DateHelper.convert(element.endDate?.timestamp)),
          id: element.id ?? -1,
          paymentsFromStore: getPayments(element.paymentsFromStore ?? []),
          startDate: DateFormat.yMd()
              .format(DateHelper.convert(element.startDate?.timestamp)),
          status: element.status ?? '',
          total: Total(
              advancePayment: element.total?.advancePayment,
              packageCost: element.total?.packageCost ?? 0,
              sumPayments: element.total?.sumPayments ?? 0,
              total: element.total?.total ?? 0,
              captainOffer: element.total?.captainOfferPrice ?? 0),
          flag: element.flag,
          note: element.note,
          packageName: element.packageName ?? S.current.unknown,
          captainsOffer: _getCaptainsOffer(element.captainOffers ?? [])
          ));
    });
  }
   List<CaptainOffer> _getCaptainsOffer(List<CaptainOffer> offers) {
    List<CaptainOffer> captains = [];
    offers.forEach((element) {
      captains.add(CaptainOffer(
          id: element.id, price: element.price, startDate: element.startDate));
    });
    return captains;
  }

  List<StoreSubscriptionsFinanceModel> get data => _data;

  List<PaymentModel> getPayments(List<PaymentsFromStore> p) {
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
  num packageCost;
  num sumPayments;
  num total;
  num captainOffer;
  Total(
      {required this.advancePayment,
      required this.packageCost,
      required this.sumPayments,
      required this.total,
      required this.captainOffer});
}
