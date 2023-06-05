import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/delivery_company_all_settings_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'external_delivery_companies_routes.dart';

@injectable
class ExternalDeliveryCompaniesModule extends YesModule {
  final ExternalDeliveryCompaniesScreen externalDeliveryCompaniesScreen;
  final DeliveryCompanyAllSettingsScreen deliveryCompanyAllSettingsScreen;

  ExternalDeliveryCompaniesModule(this.externalDeliveryCompaniesScreen,
      this.deliveryCompanyAllSettingsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      ExternalDeliveryCompaniesRoutes.EXTERNAL_COMPANY_SCREEN: (context) =>
          externalDeliveryCompaniesScreen,
      ExternalDeliveryCompaniesRoutes.Delivery_COMPANY_ALL_SETTINGS_SCREEN:
          (context) => deliveryCompanyAllSettingsScreen
    };
  }
}
