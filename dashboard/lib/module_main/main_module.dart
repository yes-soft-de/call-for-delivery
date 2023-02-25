import 'package:c4d/module_main/sceen/new_home_screen.dart';
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
  final NewHomeScreen newhomeScreen;
  MainModule(this.mainScreen, this.homeScreen, this.newhomeScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      MainRoutes.MAIN_SCREEN: (context) => mainScreen,
      MainRoutes.HOME_SCREEN: (context) => homeScreen,
      MainRoutes.NEW_HOME_SCREEN: (context) => newhomeScreen
    };
  }
}
