import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/assign_order_to_external_company_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/delivery_company_all_settings_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/edit_delivery_company_setting_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'external_delivery_companies_routes.dart';

@injectable
class ExternalDeliveryCompaniesModule extends YesModule {
  final ExternalDeliveryCompaniesScreen externalDeliveryCompaniesScreen;
  final DeliveryCompanyAllSettingsScreen deliveryCompanyAllSettingsScreen;
  final EditDeliveryCompanySettingScreen editDeliveryCompanySettingScreen;
  final AssignOrderToExternalCompanyScreen assignOrderToExternalCompanyScreen;

  ExternalDeliveryCompaniesModule(
    this.externalDeliveryCompaniesScreen,
    this.deliveryCompanyAllSettingsScreen,
    this.editDeliveryCompanySettingScreen,
    this.assignOrderToExternalCompanyScreen,
  ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      ExternalDeliveryCompaniesRoutes.EXTERNAL_COMPANY_SCREEN: (context) =>
          externalDeliveryCompaniesScreen,
      ExternalDeliveryCompaniesRoutes.Delivery_COMPANY_ALL_SETTINGS_SCREEN:
          (context) => deliveryCompanyAllSettingsScreen,
      ExternalDeliveryCompaniesRoutes.EDIT_Delivery_COMPANY_SETTINGS_SCREEN:
          (context) => editDeliveryCompanySettingScreen,
      ExternalDeliveryCompaniesRoutes.ASSIGN_ORDER_TO_EXTERNAL_COMPANY_SCREEN:
          (context) => assignOrderToExternalCompanyScreen
    };
  }
}
