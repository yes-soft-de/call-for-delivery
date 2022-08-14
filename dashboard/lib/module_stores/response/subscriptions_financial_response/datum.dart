import 'package:c4d/module_orders/response/orders_response/datum.dart';
import 'package:c4d/module_stores/response/subscriptions_financial_response/captain_offer.dart';
import 'package:c4d/module_stores/response/subscriptions_financial_response/payments_from_company.dart';

import 'end_date.dart';
import 'start_date.dart';
import 'total.dart';

class Datum {
  int? id;
  String? packageName;
  StartDate? startDate;
  EndDate? endDate;
  String? status;
  String? note;
  dynamic flag;
  List<PaymentsFromStore>? paymentsFromStore;
  Total? total;
  List<CaptainOffer>? captainOffers;
  String? packageNote;
  List<DatumOrder>? ordersExceedGeographicalRange;
  num? remainingOrders;
  num? remainingCars;
  num? packageOrderCount;
  num? packageCarCount;
  bool? isFuture;
  Datum(
      {this.id,
      this.packageName,
      this.startDate,
      this.endDate,
      this.status,
      this.note,
      this.flag,
      this.paymentsFromStore,
      this.total,
      this.captainOffers,
      this.packageCarCount,
      this.packageOrderCount,
      this.remainingCars,
      this.remainingOrders,
      this.isFuture,
      this.ordersExceedGeographicalRange,
      this.packageNote});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        isFuture: json['isFuture'] as bool?,
        remainingOrders: json['remainingOrders'] as num?,
        remainingCars: json['remainingCars'] as num?,
        packageOrderCount: json['packageOrderCount'] as num?,
        packageCarCount: json['packageCarCount'] as num?,
        packageName: json['packageName'] as String?,
        packageNote: json['packageNote'] as String?,
        startDate: json['startDate'] == null
            ? null
            : StartDate.fromJson(json['startDate'] as Map<String, dynamic>),
        endDate: json['endDate'] == null
            ? null
            : EndDate.fromJson(json['endDate'] as Map<String, dynamic>),
        status: json['status'] as String?,
        note: json['note'] as dynamic,
        flag: json['flag'] as dynamic,
        captainOffers: (json['captainOffers'] as List<dynamic>?)
            ?.map((e) => CaptainOffer.fromJson(e as Map<String, dynamic>))
            .toList(),
        ordersExceedGeographicalRange:
            (json['ordersExceedGeographicalRange'] as List<dynamic>?)
                ?.map((e) => DatumOrder.fromJson(e as Map<String, dynamic>))
                .toList(),
        paymentsFromStore: (json['paymentsFromStore'] as List<dynamic>?)
            ?.map((e) => PaymentsFromStore.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] == null
            ? null
            : Total.fromJson(json['total'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'packageName': packageName,
        'startDate': startDate?.toJson(),
        'endDate': endDate?.toJson(),
        'status': status,
        'note': note,
        'flag': flag,
        'paymentsFromStore': paymentsFromStore,
        'total': total?.toJson(),
      };
}
