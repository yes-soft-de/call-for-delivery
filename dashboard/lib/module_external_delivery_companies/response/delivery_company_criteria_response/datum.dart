import 'package:c4d/utils/helpers/date_converter.dart';

import 'from_stores_branch.dart';

class Datum {
  int? id;
  String? criteriaName;
  bool? isSpecificDate;
  DateTime? fromDate;
  DateTime? toDate;
  int? isDistance;
  int? fromDistance;
  int? toDistance;
  int? payment;
  bool? isFromAllStores;
  List<FromStoresBranch>? fromStoresBranches;
  String? updatedByAdminName;
  bool? status;
  int? cashLimit;

  Datum({
    this.id,
    this.criteriaName,
    this.isSpecificDate,
    this.fromDate,
    this.toDate,
    this.isDistance,
    this.fromDistance,
    this.toDistance,
    this.payment,
    this.isFromAllStores,
    this.fromStoresBranches,
    this.updatedByAdminName,
    this.status,
    this.cashLimit,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as int?,
      cashLimit: json['cashLimit'] as int?,
      criteriaName: json['criteriaName'] as String?,
      isSpecificDate: json['isSpecificDate'] as bool?,
      fromDate: json['fromDate']['timestamp'] == null
          ? null
          : DateHelper.convertUTC(json['fromDate']['timestamp'] as int),
      toDate: json['toDate']['timestamp'] == null
          ? null
          : DateHelper.convertUTC(json['toDate']['timestamp'] as int),
      isDistance: json['isDistance'] as int?,
      fromDistance: json['fromDistance'] as int?,
      toDistance: json['toDistance'] as int?,
      payment: json['payment'] as int?,
      isFromAllStores: json['isFromAllStores'] as bool?,
      fromStoresBranches: (json['fromStoresBranches'] as List<dynamic>?)
          ?.map((e) => FromStoresBranch.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedByAdminName: json['updatedByAdminName'] as String?,
      status: json['status'] as bool?);

  Map<String, dynamic> toJson() => {
        'id': id,
        'criteriaName': criteriaName,
        'isSpecificDate': isSpecificDate,
        'fromDate': fromDate?.toIso8601String(),
        'toDate': toDate?.toIso8601String(),
        'isDistance': isDistance,
        'fromDistance': fromDistance,
        'toDistance': toDistance,
        'payment': payment,
        'isFromAllStores': isFromAllStores,
        // 'fromStoresBranches':
        //     fromStoresBranches?.map((e) => e.toJson()).toList(),
        'updatedByAdminName': updatedByAdminName,
      };
}
