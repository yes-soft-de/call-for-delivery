import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:c4d/module_settings/ui/settings_page/choose_local_page.dart';
import 'package:c4d/module_settings/ui/settings_page/settings_page.dart';

@injectable
class SettingsModule extends YesModule {
  final SettingsScreen settingsScreen;
  final ChooseLocalScreen chooseLocalScreen;
  SettingsModule(this.settingsScreen, this.chooseLocalScreen) {
    YesModule.RoutesMap.addAll({
      SettingRoutes.ROUTE_SETTINGS: (context) => settingsScreen,
      SettingRoutes.CHOOSE_LANGUAGE: (context) => chooseLocalScreen
    });
  }
}
