import 'end_date.dart';
import 'start_date.dart';

class Data {
  int? id;
  int? packageId;
  String? packageName;
  int? remainingOrders;
  int? remainingCars;
  String? status;
  StartDate? startDate;
  EndDate? endDate;
  int? packageCarCount;
  int? packageOrderCount;

  Data({
    this.id,
    this.packageId,
    this.packageName,
    this.remainingOrders,
    this.remainingCars,
    this.status,
    this.startDate,
    this.endDate,
    this.packageCarCount,
    this.packageOrderCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        packageId: json['packageId'] as int?,
        packageName: json['packageName'] as String?,
        remainingOrders: json['remainingOrders'] as int?,
        remainingCars: json['remainingCars'] as int?,
        status: json['status'] as String?,
        startDate: json['startDate'] == null
            ? null
            : StartDate.fromJson(json['startDate'] as Map<String, dynamic>),
        endDate: json['endDate'] == null
            ? null
            : EndDate.fromJson(json['endDate'] as Map<String, dynamic>),
        packageCarCount: json['packageCarCount'] as int?,
        packageOrderCount: json['packageOrderCount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'packageId': packageId,
        'packageName': packageName,
        'remainingOrders': remainingOrders,
        'remainingCars': remainingCars,
        'status': status,
        'startDate': startDate?.toJson(),
        'endDate': endDate?.toJson(),
        'packageCarCount': packageCarCount,
        'packageOrderCount': packageOrderCount,
      };
}
