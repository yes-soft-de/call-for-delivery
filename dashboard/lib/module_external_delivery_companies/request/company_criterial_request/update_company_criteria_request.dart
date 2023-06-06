import 'dart:convert';

import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateCompanyCriterialRequest {
  int id;
  String criteriaName;
  bool isSpecificDate;
  TimeOfDay fromDate;
  TimeOfDay toDate;

  /// 205: off. 206: storeBranchToClientDistance
  int isDistance;
  int fromDistance;
  int toDistance;

  /// 207: off. 208: card. 209: cash. 210: both
  int payment;
  bool isFromAllStores;
  List<int> fromStoresBranches;

  UpdateCompanyCriterialRequest({
    required this.id,
    required this.criteriaName,
    required this.isSpecificDate,
    required this.fromDate,
    required this.toDate,
    required this.isDistance,
    required this.fromDistance,
    required this.toDistance,
    required this.payment,
    required this.isFromAllStores,
    required this.fromStoresBranches,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'criteriaName': criteriaName,
      'isSpecificDate': isSpecificDate,
      'fromDate': _dateFormat(fromDate),
      'toDate': _dateFormat(toDate),
      'isDistance': isDistance,
      'fromDistance': fromDistance,
      'toDistance': toDistance,
      'payment': payment,
      'isFromAllStores': isFromAllStores,
      'fromStoresBranches': fromStoresBranches,
    };
  }

  factory UpdateCompanyCriterialRequest.fromMap(Map<String, dynamic> map) {
    return UpdateCompanyCriterialRequest(
      id: (map['id'] ?? 0) as int,
      criteriaName: (map['criteriaName'] ?? '') as String,
      isSpecificDate: (map['isSpecificDate'] ?? false) as bool,
      fromDate: (map['fromDate'] ?? '') as TimeOfDay,
      toDate: (map['toDate'] ?? '') as TimeOfDay,
      isDistance: (map['isDistance'] ?? 0) as int,
      fromDistance: (map['fromDistance'] ?? 0) as int,
      toDistance: (map['toDistance'] ?? 0) as int,
      payment: (map['payment'] ?? 0) as int,
      isFromAllStores: (map['isFromAllStores'] ?? false) as bool,
      fromStoresBranches: List<int>.from(
          (map['fromStoresBranches'] ?? const <int>[]) as List<int>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateCompanyCriterialRequest.fromJson(String source) =>
      UpdateCompanyCriterialRequest.fromMap(
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
