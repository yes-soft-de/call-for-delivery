import 'package:c4d/module_subscriptions/subscriptions_routes.dart';
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_details_screen.dart';
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart';
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_screen.dart';
import 'package:c4d/module_subscriptions/ui/screen/subscriptions_managment_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

@injectable
class SubscriptionsModule extends YesModule {
  final StoreSubscriptionsFinanceScreen storeSubscriptionsFinanceScreen;
  final StoreSubscriptionsFinanceDetailsScreen
      storeSubscriptionsFinanceDetailsScreen;
  final SubscriptionManagementScreen subscriptionManagementScreen;
  final StoreSubscriptionsExpiredFinanceScreen
      subscriptionsExpiredFinanceScreen;
  SubscriptionsModule(
      this.storeSubscriptionsFinanceDetailsScreen,
      this.storeSubscriptionsFinanceScreen,
      this.subscriptionManagementScreen,
      this.subscriptionsExpiredFinanceScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      SubscriptionsRoutes.SUBSCRIPTIONS_DUES_SCREEN: (context) =>
          storeSubscriptionsFinanceScreen,
      SubscriptionsRoutes.SUBSCRIPTIONS_DUES_DETAILS_SCREEN: (context) =>
          storeSubscriptionsFinanceDetailsScreen,
      SubscriptionsRoutes.SUBSCRIPTIONS_MANAGEMENT: (context) =>
          subscriptionManagementScreen,
      SubscriptionsRoutes.SUBSCRIPTIONS_EXPIRED_DUES_SCREEN: (context) =>
          subscriptionsExpiredFinanceScreen,
    };
  }
}
