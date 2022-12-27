import 'package:c4d/module_delivary_car/cars_routes.dart';
import 'package:c4d/module_delivary_car/ui/screen/cars_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

@injectable
class CarsModule extends YesModule {
  final CarsScreen carsScreen;
  CarsModule(
    this.carsScreen,
  ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CarsRoutes.CARS: (context) => carsScreen,
    };
  }
}
