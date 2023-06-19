// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_subscription/response/new_subscription_balance_response/new_subscription_balance_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class NewSubscriptionBalanceModel extends DataModel {
  late String status;
  late num orderCount;
  late num toBePayed;
  late num openPriceOrder;
  late num costPerKM;
  late bool hasToPay;
  late DateTime startDate;

  NewSubscriptionBalanceModel({
    required this.status,
    required this.orderCount,
    required this.toBePayed,
    required this.openPriceOrder,
    required this.costPerKM,
    required this.hasToPay,
    required this.startDate,
  });
  late NewSubscriptionBalanceModel _balance;

  NewSubscriptionBalanceModel.withData(
      NewSubscriptionBalanceResponse response) {
    var data = response.data;
    _balance = NewSubscriptionBalanceModel(
      status: data?.status ?? 'inactive',
      costPerKM: data?.costPerKM ?? -1,
      openPriceOrder: data?.openPriceOrder ?? -1,
      orderCount: data?.orderCount ?? -1,
      toBePayed: data?.toBePayed ?? -1,
      hasToPay: data?.hasToPay ?? false,
      startDate: DateHelper.convert(data?.startDate?.timestamp),
    );
  }
  NewSubscriptionBalanceModel get data => _balance;
}
