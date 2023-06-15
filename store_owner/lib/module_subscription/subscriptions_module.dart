import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_subscription/subscriptions_routes.dart';
import 'package:c4d/module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart';
import 'package:c4d/module_subscription/ui/screens/new_subscription_balance_screen/new_subscription_balance_screen.dart';
import 'package:c4d/module_subscription/ui/screens/store_subscriptions_details_screen.dart';
import 'package:c4d/module_subscription/ui/screens/store_subscriptions_screen.dart';
import 'package:c4d/module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscriptionsModule extends YesModule {
  final InitSubscriptionScreen _initSubscriptionsScreen;
  final SubscriptionBalanceScreen _subscriptionBalanceScreen;
  final NewSubscriptionBalanceScreen _newSubscriptionBalanceScreen;
  final StoreSubscriptionsFinanceScreen _storeSubscriptionsFinanceScreen;
  final StoreSubscriptionsFinanceDetailsScreen
      storeSubscriptionsFinanceDetailsScreen;
  SubscriptionsModule(
    this._initSubscriptionsScreen,
    this._subscriptionBalanceScreen,
    this._storeSubscriptionsFinanceScreen,
    this.storeSubscriptionsFinanceDetailsScreen,
    this._newSubscriptionBalanceScreen,
  ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      SubscriptionsRoutes.INIT_SUBSCRIPTIONS_SCREEN: (context) =>
          _initSubscriptionsScreen,
      SubscriptionsRoutes.SUBSCRIPTIONS_SCREEN: (context) =>
          _subscriptionBalanceScreen,
      SubscriptionsRoutes.NEW_SUBSCRIPTIONS_SCREEN: (context) =>
          _newSubscriptionBalanceScreen,
      SubscriptionsRoutes.SUBSCRIPTIONS_DUES_SCREEN: (context) =>
          _storeSubscriptionsFinanceScreen,
      SubscriptionsRoutes.SUBSCRIPTIONS_DUES_DETAILS_SCREEN: (context) =>
          storeSubscriptionsFinanceDetailsScreen,
    };
  }
}
