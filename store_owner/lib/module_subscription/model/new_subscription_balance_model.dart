// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/response/new_subscription_balance_response/new_subscription_balance_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class NewSubscriptionBalanceModel extends DataModel {
  late int id;
  late int packageId;
  late int packageType;
  late String packageName;
  late String status;
  late int expired;
  late num geographicalRange;
  late num orderCount;
  late num toBePayed;
  late num openPriceOrder;
  late num costPerKM;
  late num whenToPay;
  late DateTime startDate;

  NewSubscriptionBalanceModel({
    required this.id,
    required this.packageId,
    required this.packageType,
    required this.packageName,
    required this.status,
    required this.expired,
    required this.geographicalRange,
    required this.orderCount,
    required this.toBePayed,
    required this.openPriceOrder,
    required this.costPerKM,
    required this.whenToPay,
    required this.startDate,
  });
  late NewSubscriptionBalanceModel _balance;

  NewSubscriptionBalanceModel.withData(
      NewSubscriptionBalanceResponse response) {
    var data = response.data;
    _balance = NewSubscriptionBalanceModel(
      id: data?.id ?? -1,
      packageType: data?.packageType ?? -1,
      packageName: data?.packageName ?? S.current.unknown,
      status: data?.status ?? 'inactive',
      expired: data?.expired ?? 0,
      geographicalRange: data?.geographicalRange ?? 0,
      costPerKM: data?.costPerKM ?? -1,
      openPriceOrder: data?.openPriceOrder ?? -1,
      orderCount: data?.orderCount ?? -1,
      packageId: data?.packageId ?? -1,
      toBePayed: data?.toBePayed ?? -1,
      whenToPay: data?.whenToPay ?? -1,
      startDate: DateHelper.convert(data?.startDate?.timestamp),
    );
  }
  NewSubscriptionBalanceModel get data => _balance;
}
