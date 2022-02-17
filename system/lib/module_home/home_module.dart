import 'package:c4d/module_home/home_routes.dart';
import 'package:c4d/module_home/ui/screen/home_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

@injectable
class HomeModule extends YesModule {
  final HomeScreen homeScreen;
  HomeModule(this.homeScreen) {
    YesModule.RoutesMap.addAll({
      HomeRoutes.ROUTE_HOME: (context) => homeScreen,
    });
  }
}
