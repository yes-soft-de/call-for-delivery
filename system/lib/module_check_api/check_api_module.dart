import 'package:c4d/module_check_api/check_api_routes.dart';
import 'package:c4d/module_check_api/ui/screen/check_api_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

@injectable
class CheckApiModule extends YesModule {
  final CheckApiScreen homeScreen;
  CheckApiModule(this.homeScreen) {
    YesModule.RoutesMap.addAll({
      CheckApiRoutes.ROUTE_CheckApi: (context) => homeScreen,
    });
  }
}
