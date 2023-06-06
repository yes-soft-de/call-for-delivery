// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_external_delivery_companies/response/delivery_company_criteria_response/delivery_company_criteria_response.dart';
import 'package:flutter/material.dart';

class CompanySetting extends DataModel {
  late int id;
  late String settingName;
  late bool isActive;
  late FromTo<int> distance;
  late FromTo<TimeOfDay> workingHours;
  late StoreType storeType;
  late List<BranchesModel> branches;
  late PaymentType paymentType;

  CompanySetting({
    required this.id,
    required this.settingName,
    required this.isActive,
    required this.distance,
    required this.workingHours,
    required this.storeType,
    required this.branches,
    required this.paymentType,
  });

  CompanySetting.empty()
      : distance = FromTo<int>(isFilterActive: false, from: 0, to: 0),
        id = -1,
        isActive = false,
        paymentType = PaymentType.all,
        settingName = '',
        storeType = StoreType.all,
        branches = [],
        workingHours = FromTo<TimeOfDay>(
          from: TimeOfDay.now(),
          isFilterActive: false,
          to: TimeOfDay.now(),
        );

  CompanySetting.withData(DeliveryCompanyCriteriaResponse response) {
    var data = response.data;

    data?.forEach(
      (element) {
        _companySetting.add(
          CompanySetting(
            id: element.id ?? -1,
            distance: FromTo<int>(
              from: element.fromDistance ?? 0,
              isFilterActive: element.isDistance == 206,
              to: element.toDistance ?? 0,
            ),
            isActive: element.status ?? false,
            paymentType: _getPaymentType(element.payment),
            settingName: element.criteriaName ?? '',
            storeType: _getStoreType(element.isFromAllStores),
            branches: [], // TODO: element.fromStoresBranches
            workingHours: FromTo<TimeOfDay>(
              from: TimeOfDay.fromDateTime(element.fromDate ?? DateTime.now()),
              isFilterActive: element.isSpecificDate ?? false,
              to: TimeOfDay.fromDateTime(element.toDate ?? DateTime.now()),
            ),
          ),
        );
      },
    );
  }

  PaymentType _getPaymentType(int? payment) {
    if (payment == 208) return PaymentType.card;
    if (payment == 209) return PaymentType.cash;
    return PaymentType.all;
  }

  StoreType _getStoreType(bool? isAllStore) {
    if (isAllStore ?? false) return StoreType.all;
    return StoreType.some;
  }

  late List<CompanySetting> _companySetting = [];
  List<CompanySetting> get data => _companySetting;
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
