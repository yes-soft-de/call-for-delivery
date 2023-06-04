import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'external_delivery_companies_routes.dart';

@injectable
class ExternalDeliveryCompaniesModule extends YesModule {
  final ExternalDeliveryCompaniesScreen externalDeliveryCompaniesScreen;

  ExternalDeliveryCompaniesModule(this.externalDeliveryCompaniesScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      ExternalDeliveryCompaniesRoutes.EXTERNAL_COMPANY_SCREEN: (context) =>
          externalDeliveryCompaniesScreen
    };
  }
}
