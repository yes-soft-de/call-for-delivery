import 'end_date.dart';
import 'start_date.dart';

class Data {
  int? id;
  int? packageId;
  int? packageType;
  String? packageName;
  String? status;
  StartDate? startDate;
  EndDate? endDate;
  int? expired;
  num? geographicalRange;
  num? orderCount;
  num? toBePayed;
  num? openPriceOrder;
  num? costPerKM;
  num? whenToPay;

  Data({
    this.id,
    this.packageId,
    this.packageType,
    this.packageName,
    this.status,
    this.startDate,
    this.endDate,
    this.expired,
    this.geographicalRange,
    this.costPerKM,
    this.openPriceOrder,
    this.orderCount,
    this.toBePayed,
    this.whenToPay,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        packageId: json['packageId'] as int?,
        packageType: json['packageType'] as int?,
        packageName: json['packageName'] as String?,
        status: json['status'] as String?,
        startDate: json['startDate'] == null
            ? null
            : StartDate.fromJson(json['startDate'] as Map<String, dynamic>),
        endDate: json['endDate'] == null
            ? null
            : EndDate.fromJson(json['endDate'] as Map<String, dynamic>),
        expired: json['expired'] as int?,
        geographicalRange: json['geographicalRange'],
        costPerKM: json[''] as num?,
        openPriceOrder: json[''] as num?,
        orderCount: json[''] as num?,
        toBePayed: json[''] as num?,
        whenToPay: json[''] as num?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'packageId': packageId,
        'packageName': packageName,
        'status': status,
        'startDate': startDate?.toJson(),
        'endDate': endDate?.toJson(),
      };
}
