// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CompanySetting {
  late int id;
  late String companyName;
  late String settingName;
  late bool isActive;
  late FromTo<int> distance;
  late FromTo<TimeOfDay> workingHours;
  late StoreType storeType;
  late List<String> stores;
  late PaymentType paymentType;

  CompanySetting({
    required this.id,
    required this.companyName,
    required this.settingName,
    required this.isActive,
    required this.distance,
    required this.workingHours,
    required this.storeType,
    required this.stores,
    required this.paymentType,
  });

  late List<CompanySetting> _companySetting;
}

class FromTo<T> {
  bool isFilterActive;
  T from;
  T to;

  FromTo({
    required this.isFilterActive,
    required this.from,
    required this.to,
  });
}

enum StoreType { all, some }

enum PaymentType { all, cash, card }
