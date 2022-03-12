import 'package:c4d/module_settings/ui/settings_page/copy_map_link.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:c4d/module_settings/ui/settings_page/choose_local_page.dart';
import 'package:c4d/module_settings/ui/settings_page/settings_page.dart';

@injectable
class SettingsModule extends YesModule {
  final SettingsScreen settingsScreen;
  final ChooseLocalScreen chooseLocalScreen;
  final CopyMapLinkScreen copyMapLinkScreen;
  SettingsModule(
      this.settingsScreen, this.chooseLocalScreen, this.copyMapLinkScreen) {
    YesModule.RoutesMap.addAll({
      SettingRoutes.ROUTE_SETTINGS: (context) => settingsScreen,
      SettingRoutes.CHOOSE_LANGUAGE: (context) => chooseLocalScreen,
      SettingRoutes.COPY_LINK_SCREEN: (context) => copyMapLinkScreen,
    });
  }
}
