import 'package:c4d/module_captain/captains_routes.dart';
import 'package:c4d/module_captain/ui/screen/captain_needs_support_screen.dart';
import 'package:c4d/module_captain/ui/screen/captain_profile_screen.dart';
import 'package:c4d/module_captain/ui/screen/captains_list_screen.dart';
import 'package:c4d/module_captain/ui/screen/in_active_captains_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';


@injectable
class CaptainsModule extends YesModule {

  final InActiveCaptainsScreen inActiveCaptains;
  final CaptainsScreen captainsScreen;
  final CaptainProfileScreen captainProfileScreen;
  final CaptainsNeedsSupportScreen supportScreen;

  CaptainsModule(
    this.inActiveCaptains,
    this.captainsScreen,
    this.captainProfileScreen,
    this.supportScreen,
  ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CaptainsRoutes.CAPTAINS: (context) => captainsScreen,
      CaptainsRoutes.CAPTAIN_PROFILE: (context) => captainProfileScreen,
      CaptainsRoutes.IN_ACTIVE_CAPTAINS: (context) => inActiveCaptains,
      CaptainsRoutes.CAPTAIN_SUPPORT: (context) => supportScreen,
    };
  }
}
