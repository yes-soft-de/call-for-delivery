import 'start_date.dart';

class Data {
  String? status;
  StartDate? startDate;
  num? orderCount;
  num? toBePayed;
  num? openPriceOrder;
  num? costPerKM;
  bool? hasToPay;

  Data({
    this.status,
    this.startDate,
    this.costPerKM,
    this.openPriceOrder,
    this.orderCount,
    this.toBePayed,
    this.hasToPay,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json['subscriptionStatus'] as String?,
        startDate: json['subscriptionStartDate'] == null
            ? null
            : StartDate.fromJson(json['startDate'] as Map<String, dynamic>),
        costPerKM: json['oneKilometerCost'] as num?,
        openPriceOrder: json['openingOrderCost'] as num?,
        orderCount: json['deliveredOrdersCount'] as num?,
        toBePayed: json['deliveredOrdersCostsSum'] as num?,
        hasToPay: json['hasToPay'] as bool?,
      );
}
