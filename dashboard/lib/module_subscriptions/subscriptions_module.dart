import 'package:c4d/module_subscriptions/subscriptions_routes.dart';
import 'package:c4d/module_subscriptions/ui/screen/edit_subscription_screen.dart';
import 'package:c4d/module_subscriptions/ui/screen/init_subscription_screen.dart';
import 'package:c4d/module_subscriptions/ui/screen/receipts_screen.dart';
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_details_screen.dart';
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart';
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_screen.dart';
import 'package:c4d/module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart';
import 'package:c4d/module_subscriptions/ui/screen/subscriptions_managment_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

@injectable
class SubscriptionsModule extends YesModule {
  SubscriptionsModule() {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      SubscriptionsRoutes.SUBSCRIPTIONS_DUES_SCREEN: (context) =>
          StoreSubscriptionsFinanceScreen(),
      SubscriptionsRoutes.SUBSCRIPTIONS_DUES_DETAILS_SCREEN: (context) =>
          StoreSubscriptionsFinanceDetailsScreen(),
      SubscriptionsRoutes.SUBSCRIPTIONS_MANAGEMENT: (context) =>
          SubscriptionManagementScreen(),
      SubscriptionsRoutes.SUBSCRIPTIONS_EXPIRED_DUES_SCREEN: (context) =>
          StoreSubscriptionsExpiredFinanceScreen(),
      SubscriptionsRoutes.CREATE_NEW_SUBSCRIPTION_SCREEN: (context) =>
          CreateSubscriptionScreen(),
      SubscriptionsRoutes.EDIT_SUBSCRIPTION_SCREEN: (context) =>
          EditSubscriptionScreen(),
      SubscriptionsRoutes.CREATE_NEW_SUBSCRIPTION_TO_CAPTAIN_OFFER_SCREEN:
          (context) => CreateSubscriptionToCaptainOfferScreen(),
      SubscriptionsRoutes.RECEIPTS_SCREEN: (context) => ReceiptsScreen(),
    };
  }
}
