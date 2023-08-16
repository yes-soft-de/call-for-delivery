import 'dart:convert';

import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateCompanyCriteria {
  bool status;
  String criteriaName;
  List<int> fromStoresBranches;
  bool isFromAllStores;
  int externalDeliveryCompany;
  int? cashLimit;

  /// 207: off. 208: card. 209: cash. 210: both
  int payment;

  ///205: off. 206: storeBranchToClientDistance
  int isDistance;
  int toDistance;
  int fromDistance;

  bool isSpecificDate;
  TimeOfDay toDate;
  TimeOfDay fromDate;

  CreateCompanyCriteria({
    required this.status,
    required this.cashLimit,
    required this.criteriaName,
    required this.fromStoresBranches,
    required this.isFromAllStores,
    required this.externalDeliveryCompany,
    required this.payment,
    required this.isDistance,
    required this.toDistance,
    required this.fromDistance,
    required this.isSpecificDate,
    required this.toDate,
    required this.fromDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'criteriaName': criteriaName,
      'fromStoresBranches': fromStoresBranches,
      'isFromAllStores': isFromAllStores,
      'externalDeliveryCompany': externalDeliveryCompany,
      'payment': payment,
      'isDistance': isDistance,
      'toDistance': toDistance,
      'fromDistance': fromDistance,
      'isSpecificDate': isSpecificDate,
      'toDate': _dateFormat(toDate),
      'fromDate': _dateFormat(fromDate),
    };
  }

  factory CreateCompanyCriteria.fromMap(Map<String, dynamic> map) {
    return CreateCompanyCriteria(
      cashLimit: map['cashLimit'] as int?,
      status: (map['status'] ?? false) as bool,
      criteriaName: (map['criteriaName'] ?? '') as String,
      fromStoresBranches: List<int>.from(
          (map['fromStoresBranches'] ?? const <int>[]) as List<int>),
      isFromAllStores: (map['isFromAllStores'] ?? false) as bool,
      externalDeliveryCompany: (map['externalDeliveryCompany'] ?? 0) as int,
      payment: (map['payment'] ?? 0) as int,
      isDistance: (map['isDistance'] ?? false) as int,
      toDistance: (map['toDistance'] ?? 0) as int,
      fromDistance: (map['fromDistance'] ?? 0) as int,
      isSpecificDate: (map['isSpecificDate'] ?? false) as bool,
      toDate: (map['toDate'] ?? '') as TimeOfDay,
      fromDate: (map['fromDate'] ?? '') as TimeOfDay,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateCompanyCriteria.fromJson(String source) =>
      CreateCompanyCriteria.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

String _dateFormat(TimeOfDay timeOfDay) {
  String result = '2020-06-06 ';

  result += '${timeOfDay.hour}';
  result += ':';
  result += '${timeOfDay.minute}';
  result += ':';
  result += '00';

  return result;
}
