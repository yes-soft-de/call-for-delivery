import 'package:c4d/module_captain/captains_routes.dart';
import 'package:c4d/module_captain/ui/screen/captain_activity_details_screen.dart';
import 'package:c4d/module_captain/ui/screen/captain_activity_model.dart';
import 'package:c4d/module_captain/ui/screen/captain_dues_screen.dart';
import 'package:c4d/module_captain/ui/screen/captain_needs_support_screen.dart';
import 'package:c4d/module_captain/ui/screen/captain_profile_screen.dart';
import 'package:c4d/module_captain/ui/screen/captain_rating_screen.dart';
import 'package:c4d/module_captain/ui/screen/captains_assign_order_screen.dart';
import 'package:c4d/module_captain/ui/screen/captains_list_screen.dart';
import 'package:c4d/module_captain/ui/screen/captin_rating_details_state.dart';
import 'package:c4d/module_captain/ui/screen/change_captain_plan_screen.dart';
import 'package:c4d/module_captain/ui/screen/in_active_captains_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

import 'ui/screen/captains_offer_screen.dart';

@injectable
class CaptainsModule extends YesModule {
  CaptainsModule() {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CaptainsRoutes.OFFER: (context) => CaptainOffersScreen(),
      CaptainsRoutes.CAPTAINS: (context) => CaptainsScreen(),
      CaptainsRoutes.CAPTAIN_PROFILE: (context) => CaptainProfileScreen(),
      CaptainsRoutes.IN_ACTIVE_CAPTAINS: (context) => InActiveCaptainsScreen(),
      CaptainsRoutes.CAPTAIN_SUPPORT: (context) => CaptainsNeedsSupportScreen(),
      CaptainsRoutes.CAPTAIN_PLAN: (context) => PlanScreen(),
      CaptainsRoutes.ASSIGN_TO_CAPTAIN: (context) => CaptainAssignOrderScreen(),
      CaptainsRoutes.CAPTAIN_RATING: (context) => CaptainsRatingScreen(),
      CaptainsRoutes.CAPTAIN_RATING_DETAILS: (context) =>
          CaptainRatingDetailsScreen(),
      CaptainsRoutes.CAPTAIN_ACTIVITY: (context) => CaptainsActivityScreen(),
      CaptainsRoutes.CAPTAIN_ACTIVITY_DETAILS: (context) =>
          CaptainActivityDetailsScreen(),
      CaptainsRoutes.CAPTAIN_DUES: (context) => CaptainDuesScreen(),
    };
  }
}
