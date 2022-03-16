import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_about/about_routes.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/screen/company_info/company_info_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class AboutModule extends YesModule {
  final AboutScreen _aboutScreen;
  final CompanyInfoScreen _companyInfoScreen;
  AboutModule(this._aboutScreen, this._companyInfoScreen) {
    YesModule.RoutesMap.addAll({
      AboutRoutes.ROUTE_ABOUT: (context) => _aboutScreen,
      AboutRoutes.ROUTE_COMPANY: (context) => _companyInfoScreen,
    });
  }
}
