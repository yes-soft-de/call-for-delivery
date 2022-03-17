import 'package:c4d/module_captain/captains_routes.dart';
import 'package:c4d/module_captain/ui/screen/captain_profile_screen.dart';
import 'package:c4d/module_captain/ui/screen/captains_list_screen.dart';
import 'package:c4d/module_captain/ui/screen/in_active_captains_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

import 'ui/screen/captains_offer_screen.dart';


@injectable
class CaptainsModule extends YesModule {
  final CaptainOffersScreen captainOffersScreen;

  final InActiveCaptainsScreen inActiveCaptains;
  final CaptainsScreen captainsScreen;
  final CaptainProfileScreen captainProfileScreen;

  CaptainsModule(
      this.captainOffersScreen, this.inActiveCaptains, this.captainsScreen, this.captainProfileScreen,
     ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CaptainsRoutes.OFFER: (context) => captainOffersScreen,
      CaptainsRoutes.CAPTAINS: (context) => captainsScreen,
      CaptainsRoutes.CAPTAIN_PROFILE: (context) => captainProfileScreen,
      CaptainsRoutes.IN_ACTIVE_CAPTAINS: (context) => inActiveCaptains,

    };
  }
}
