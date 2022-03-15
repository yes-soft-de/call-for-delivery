import 'package:c4d/module_captain/captains_routes.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

import 'ui/screen/captains_offer_screen.dart';


@injectable
class CaptainsModule extends YesModule {
  final CaptainOffersScreen captainOffersScreen;



  CaptainsModule(
      this.captainOffersScreen,
     ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CaptainsRoutes.OFFER: (context) => captainOffersScreen,
    };
  }
}
