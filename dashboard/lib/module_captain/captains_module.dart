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
  final CaptainOffersScreen captainOffersScreen;
  final CaptainProfileScreen captainProfileScreen;
  final CaptainsNeedsSupportScreen supportScreen;
  final PlanScreen planScreen;
  final CaptainAssignOrderScreen captainAssignOrderScreen;
  final CaptainsRatingScreen captainsRatingsScreen;
  final CaptinRatingDetailsScreen captainsRatingsDetailsScreen;
  final CaptainsActivityScreen captainsActivityScreen;
  final CaptainActivityDetailsScreen captainsActivityDetailsScreen;

  CaptainsModule(
    this.captainOffersScreen,
    this.captainProfileScreen,
    this.supportScreen,
    this.planScreen,
    this.captainAssignOrderScreen,
    this.captainsRatingsScreen,
    this.captainsRatingsDetailsScreen,
    this.captainsActivityScreen,
    this.captainsActivityDetailsScreen,
  ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CaptainsRoutes.OFFER: (context) => captainOffersScreen,
      CaptainsRoutes.CAPTAINS: (context) => CaptainsScreen(),
      CaptainsRoutes.CAPTAIN_PROFILE: (context) => captainProfileScreen,
      CaptainsRoutes.IN_ACTIVE_CAPTAINS: (context) => InActiveCaptainsScreen(),
      CaptainsRoutes.CAPTAIN_SUPPORT: (context) => supportScreen,
      CaptainsRoutes.CAPTAIN_PLAN: (context) => planScreen,
      CaptainsRoutes.ASSIGN_TO_CAPTAIN: (context) => captainAssignOrderScreen,
      CaptainsRoutes.CAPTAIN_RATING: (context) => captainsRatingsScreen,
      CaptainsRoutes.CAPTAIN_RATING_DETAILS: (context) =>
          captainsRatingsDetailsScreen,
      CaptainsRoutes.CAPTAIN_ACTIVITY: (context) => captainsActivityScreen,
      CaptainsRoutes.CAPTAIN_ACTIVITY_DETAILS: (context) =>
          captainsActivityDetailsScreen,
      CaptainsRoutes.CAPTAIN_DUES: (context) => CaptainDuesScreen(),
    };
  }
}
