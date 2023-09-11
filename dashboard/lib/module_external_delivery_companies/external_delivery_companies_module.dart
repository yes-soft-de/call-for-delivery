import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/assign_order_to_external_company_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/delivery_company_all_settings_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/edit_delivery_company_setting_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_orders_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/naher_evan_captain_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/naher_evan_captains_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'external_delivery_companies_routes.dart';

@injectable
class ExternalDeliveryCompaniesModule extends YesModule {
  ExternalDeliveryCompaniesModule() {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      ExternalDeliveryCompaniesRoutes.EXTERNAL_COMPANY_SCREEN: (context) =>
          ExternalDeliveryCompaniesScreen(),
      ExternalDeliveryCompaniesRoutes.Delivery_COMPANY_ALL_SETTINGS_SCREEN:
          (context) => DeliveryCompanyAllSettingsScreen(),
      ExternalDeliveryCompaniesRoutes.EDIT_Delivery_COMPANY_SETTINGS_SCREEN:
          (context) => EditDeliveryCompanySettingScreen(),
      ExternalDeliveryCompaniesRoutes.ASSIGN_ORDER_TO_EXTERNAL_COMPANY_SCREEN:
          (context) => AssignOrderToExternalCompanyScreen(),
      ExternalDeliveryCompaniesRoutes.EXTERNAL_ORDERS_SCREEN: (context) =>
          ExternalOrderScreen(),
      ExternalDeliveryCompaniesRoutes.NAHER_EVAN_CAPTAINS_SCREEN: (context) =>
          NaherEvanCaptainsScreen(),
      ExternalDeliveryCompaniesRoutes.NAHER_EVAN_CAPTAIN_SCREEN: (context) =>
          NaherEvanCaptainScreen(),
    };
  }
}
