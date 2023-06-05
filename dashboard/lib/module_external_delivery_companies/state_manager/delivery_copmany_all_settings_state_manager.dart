import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/service/external_delivery_companies_service.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/delivery_company_all_settings_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/state/delivery_copmany_all_settings_state_loaded.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class DeliveryCompanyAllSettingsStateManager {
  final ExternalDeliveryCompaniesService _service;
  final PublishSubject<States> _stateSubject = PublishSubject();

  DeliveryCompanyAllSettingsStateManager(this._service);

  void getCompanySetting(
      DeliveryCompanyAllSettingsScreenState screenState, int companyId) {
    var companySetting = [
      CompanySetting(
          companyName: '',
          isActive: true,
          id: 1,
          distance: FromTo(from: 1, to: 10, isFilterActive: true),
          settingName: 'setting 1',
          paymentType: PaymentType.all,
          storeType: StoreType.all,
          stores: [],
          workingHours:
              FromTo(from: TimeOfDay(hour: 10, minute: 30), to: TimeOfDay(hour: 11, minute: 30), isFilterActive: false)),
      CompanySetting(
          companyName: '',
          isActive: false,
          id: 2,
          distance: FromTo(from: 10, to: 100, isFilterActive: true),
          settingName: 'setting 2',
          paymentType: PaymentType.card,
          storeType: StoreType.some,
          stores: ['hi'],
          workingHours:
              FromTo(from: TimeOfDay(hour: 10, minute: 30), to: TimeOfDay(hour: 11, minute: 30), isFilterActive: true)),
      CompanySetting(
          companyName: '',
          isActive: true,
          id: 3,
          distance: FromTo(from: 1, to: 10, isFilterActive: false),
          settingName: 'setting 3',
          paymentType: PaymentType.cash,
          storeType: StoreType.all,
          stores: [],
          workingHours:
              FromTo(from: TimeOfDay(hour: 10, minute: 30), to: TimeOfDay(hour: 11, minute: 30), isFilterActive: false)),
      CompanySetting(
          companyName: '',
          isActive: false,
          id: 4,
          distance: FromTo(from: 1, to: 10, isFilterActive: true),
          settingName: 'setting 4',
          paymentType: PaymentType.all,
          storeType: StoreType.some,
          stores: ['hi', 'bey'],
          workingHours:
              FromTo(from: TimeOfDay(hour: 10, minute: 30), to: TimeOfDay(hour: 11, minute: 30), isFilterActive: true)),
    ];

    _stateSubject.add(
        DeliveryCompanyAllSettingsStateLoaded(screenState, companySetting));
  }

  Stream<States> get stateStream => _stateSubject.stream;
}
