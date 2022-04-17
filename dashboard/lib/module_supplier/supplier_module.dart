import 'package:c4d/module_supplier/supplier_routes.dart';
import 'package:c4d/module_supplier/ui/screen/supplier_ads_screen.dart';
import 'package:c4d/module_supplier/ui/screen/supplier_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

import 'ui/screen/in_active_supplier_screen.dart';
import 'ui/screen/supplier_list_screen.dart';
import 'ui/screen/supplier_needs_support_screen.dart';


@injectable
class SupplierModule extends YesModule {

  final InActiveSupplierScreen inActiveSupplierScreen;
  final SuppliersScreen suppliersScreen;
  final SupplierProfileScreen supplierProfileScreen;
  final SupplierNeedsSupportScreen supportScreen;
  final SupplierAdsScreen adsScreen;

  SupplierModule(
    this.inActiveSupplierScreen,
    this.suppliersScreen,
    this.supplierProfileScreen,
    this.supportScreen,
      this.adsScreen
  ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      SupplierRoutes.SUPPLIERS: (context) => suppliersScreen,
      SupplierRoutes.SUPPLIER_PROFILE: (context) => supplierProfileScreen,
      SupplierRoutes.IN_ACTIVE_SUPPLIER: (context) => inActiveSupplierScreen,
      SupplierRoutes.SUPPLIER_SUPPORT: (context) => supportScreen,
    };
  }
}
