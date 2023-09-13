import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_splash/splash_routes.dart';
import 'package:c4d/module_splash/ui/screen/splash_screen.dart';

@injectable
class SplashModule extends RoutingModule {
  SplashModule(SplashScreen splashScreen) {
    RoutingModule.RoutesMap.addAll(
        {SplashRoutes.SPLASH_SCREEN: (context) => splashScreen});
  }
}
