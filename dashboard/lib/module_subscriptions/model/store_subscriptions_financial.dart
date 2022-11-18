import 'package:c4d/module_orders/response/orders_response/sub_order_list/sub_order.dart';
import 'package:intl/intl.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/response/orders_response/datum.dart';
import 'package:c4d/module_subscriptions/response/subscriptions_financial_response/captain_offer.dart';
import 'package:c4d/module_subscriptions/response/subscriptions_financial_response/payments_from_company.dart';
import 'package:c4d/module_subscriptions/response/subscriptions_financial_response/subscriptions_financial_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import '../response/subscriptions_financial_response/datum.dart';

class SubscriptionsModel {
  late List<StoreSubscriptionsFinanceModel> oldSubscriptions;
  late List<StoreSubscriptionsFinanceModel> currentAndFutureSubscriptions;
  SubscriptionsModel({
    required this.oldSubscriptions,
    required this.currentAndFutureSubscriptions,
  });
  SubscriptionsModel.empty();
}

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
  late int packageCarCount;
  late int packageOrderCount;
  late int remainingCars;
  late int remainingOrders;
  late bool isFuture;
  late String packageNote;
  late List<OrderModel> ordersExceedGeographicalRange;
  bool isCurrent = false;
  late int packageType;
  SubscriptionsModel _data = SubscriptionsModel.empty();
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
    required this.captainsOffer,
    required this.packageCarCount,
    required this.packageOrderCount,
    required this.remainingCars,
    required this.remainingOrders,
    required this.isFuture,
    required this.ordersExceedGeographicalRange,
    required this.packageNote,
    required this.isCurrent,
    required this.packageType,
  });
  StoreSubscriptionsFinanceModel.withData(
      SubscriptionsFinancialResponse response) {
    var old = response.data?.oldSubscription;
    var current = response.data?.futureAndCurrentSubscription;
    List<StoreSubscriptionsFinanceModel> olds = _getSubs(old);
    List<StoreSubscriptionsFinanceModel> currents = _getSubs(current);
    _data = SubscriptionsModel(
        oldSubscriptions: olds, currentAndFutureSubscriptions: currents);
  }
  List<OrderModel> _getOrders(List<DatumOrder> o) {
    List<OrderModel> orders = [];
    o.forEach((element) {
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      // delivery date
      var delivery = DateFormat.jm()
              .format(DateHelper.convert(element.deliveryDate?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.deliveryDate?.timestamp));
      //
      orders.add(OrderModel(
        branchName: element.branchName ?? S.current.unknown,
        id: element.id ?? -1,
        createdDate: create,
        deliveryDate: delivery,
        note: element.note ?? '',
        orderCost: element.orderCost ?? 0,
        state: StatusHelper.getStatusEnum(element.state),
        storeName: element.storeOwnerName,
        orderIsMain: element.orderIsMain ?? false,
        subOrders: _getSubOrders(element.subOrders ?? []),
        kilometer: 0,
        storeBranchToClientDistance: 0,
      ));
    });
    return orders;
  }

  List<OrderModel> _getSubOrders(List<SubOrder> suborder) {
    List<OrderModel> orders = [];
    suborder.forEach((element) {
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      var delivery = DateFormat.jm()
              .format(DateHelper.convert(element.deliveryDate?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.deliveryDate?.timestamp));
      orders.add(
        OrderModel(
          branchName: element.branchName ?? S.current.unknown,
          createdDate: create,
          deliveryDate: delivery,
          id: element.id ?? -1,
          note: element.note ?? '',
          orderCost: element.orderCost ?? 0,
          orderIsMain: false,
          subOrders: [],
          state: StatusHelper.getStatusEnum(element.state),
          storeName: element.storeOwnerName,
          kilometer: 0,
          storeBranchToClientDistance: 0,
        ),
      );
    });
    return orders;
  }

  SubscriptionsModel get data => _data;
  List<StoreSubscriptionsFinanceModel> _getSubs(List<Datum>? data) {
    List<StoreSubscriptionsFinanceModel> finalData = [];
    data?.forEach((element) {
      finalData.add(StoreSubscriptionsFinanceModel(
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
            captainOffer: element.total?.captainOfferPrice ?? 0,
            requiredToPay: element.total?.requiredToPay ?? 0,
            extraCost: element.total?.extraCost ?? 0,
            totalDistanceExtra: element.total?.totalDistanceExtra ?? 0),
        flag: element.flag,
        note: element.note,
        packageName: element.packageName ?? S.current.unknown,
        captainsOffer: element.captainOffers ?? [],
        packageCarCount: element.packageCarCount?.toInt() ?? 0,
        packageOrderCount: element.packageOrderCount?.toInt() ?? 0,
        remainingCars: element.remainingCars?.toInt() ?? 0,
        remainingOrders: element.remainingOrders?.toInt() ?? 0,
        isFuture: element.isFuture ?? false,
        ordersExceedGeographicalRange:
            _getOrders(element.ordersExceedGeographicalRange ?? []),
        packageNote: element.packageNote ?? '',
        isCurrent: element.isCurrent ?? false,
        packageType: element.packageType ?? 0,
      ));
    });
    return finalData;
  }

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
  num requiredToPay;
  num totalDistanceExtra;
  num extraCost;
  Total(
      {required this.advancePayment,
      required this.packageCost,
      required this.sumPayments,
      required this.total,
      required this.captainOffer,
      required this.requiredToPay,
      required this.extraCost,
      required this.totalDistanceExtra});
}
