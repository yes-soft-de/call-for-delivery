import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_home/home_routes.dart';
import 'package:injectable/injectable.dart';

import 'ui/home_screen.dart';

@injectable
class HomeModule extends YesModule {
  final HomeScreen _homeScreen;
  HomeModule(this._homeScreen) {
    YesModule.RoutesMap.addAll({
      HomeRoutes.ROUTE_HOME: (context) => _homeScreen,
    });
  }
}
