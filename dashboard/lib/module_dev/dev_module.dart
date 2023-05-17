import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_dev/dev_routes.dart';
import 'package:c4d/module_dev/ui/screens/new_test_order/new_test_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class DevModule extends YesModule {
  final NewTestOrderScreen newTestOrderScreen;
  DevModule(this.newTestOrderScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      DevRoutes.DEV_NEW_ORDER_SCREEN: (context) => newTestOrderScreen,
    };
  }
}
