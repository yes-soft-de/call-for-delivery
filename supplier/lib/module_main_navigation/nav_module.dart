import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_main_navigation/nav_routes.dart';
import 'package:injectable/injectable.dart';

import 'ui/botto_nav_screen.dart';

@injectable
class NavigationModule extends YesModule {
  final MainNavigation navigation;
  NavigationModule(this.navigation) {
    YesModule.RoutesMap.addAll({
      NavRoutes.ROUTE_NAV: (context) => navigation,
    });
  }
}
