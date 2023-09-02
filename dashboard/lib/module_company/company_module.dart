import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_company/company_routes.dart';
import 'package:c4d/module_company/ui/screen/company_finance_screen.dart';
import 'package:c4d/module_company/ui/screen/company_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyModule extends YesModule {
  CompanyModule() {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CompanyRoutes.COMPANY_PROFILE_SCREEN: (context) => CompanyProfileScreen(),
      CompanyRoutes.COMPANY_FINANCE_SCREEN: (context) => CompanyFinanceScreen()
    };
  }
}
