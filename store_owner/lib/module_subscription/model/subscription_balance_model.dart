import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/response/subscription_balance_response/subscription_balance_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class SubscriptionBalanceModel extends DataModel {
  late int packageID;
  late int id;
  late String packageName;
  late int remainingOrders;
  late int remainingCars;
  late DateTime startDate;
  late DateTime endDate;
  late int packageCarsCount;
  late int packageOrdersCount;
  late String? status;
  late int expired;
  late double? unPaidCashOrdersSum;
  SubscriptionBalanceModel(
      {required this.packageID,
      required this.id,
      required this.remainingCars,
      required this.remainingOrders,
      required this.startDate,
      required this.endDate,
      required this.packageCarsCount,
      required this.packageOrdersCount,
      required this.packageName,
      this.status,
      required this.expired,
      this.unPaidCashOrdersSum});
  late SubscriptionBalanceModel _balance;
  SubscriptionBalanceModel.withData(SubscriptionBalanceResponse response) {
    var data = response.data;
    _balance = SubscriptionBalanceModel(
        id: data?.id ?? -1,
        endDate: DateHelper.convert(data?.endDate?.timestamp),
        packageCarsCount: data?.packageCarCount ?? 0,
        packageID: data?.packageId ?? -1,
        packageName: data?.packageName ?? S.current.unknown,
        packageOrdersCount: data?.packageOrderCount ?? 0,
        remainingCars: data?.remainingCars ?? 0,
        remainingOrders: data?.remainingOrders ?? 0,
        status: data?.status ?? 'inactive',
        startDate: DateHelper.convert(data?.startDate?.timestamp),
        expired: data?.expired ?? 0,
        unPaidCashOrdersSum: data?.unPaidCashOrdersSum ?? 0);
  }
  SubscriptionBalanceModel get data => _balance;
}
