import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_init/init_routes.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';

@injectable
class InitAccountModule extends RoutingModule {
  final InitAccountScreen _initAccountScreen;

  InitAccountModule(this._initAccountScreen) {
    RoutingModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      InitAccountRoutes.INIT_ACCOUNT_SCREEN: (context) => _initAccountScreen
    };
  }
}
