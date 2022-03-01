import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_main/main_routes.dart';
import 'package:c4d/module_main/sceen/home_screen.dart';
import 'package:c4d/module_main/sceen/main_screen.dart';

@injectable
class MainModule extends YesModule {
  final MainScreen mainScreen;
  final HomeScreen homeScreen;
  MainModule(this.mainScreen, this.homeScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      MainRoutes.MAIN_SCREEN: (context) => mainScreen,
      MainRoutes.HOME_SCREEN: (context) => homeScreen
    };
  }
}
