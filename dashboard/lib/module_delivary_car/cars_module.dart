import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

@injectable
class CarsModule extends YesModule {
  // not used
  // final CarsScreen carsScreen;
  CarsModule(
      // this.carsScreen,
      ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      // CarsRoutes.CARS: (context) => carsScreen,
    };
  }
}
