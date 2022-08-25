import 'package:c4d/module_subscriptions/subscriptions_routes.dart';
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_details_screen.dart';
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

@injectable
class StoresModule extends YesModule {
  final StoreSubscriptionsFinanceScreen storeSubscriptionsFinanceScreen;
  final StoreSubscriptionsFinanceDetailsScreen
      storeSubscriptionsFinanceDetailsScreen;

  StoresModule(this.storeSubscriptionsFinanceDetailsScreen,
      this.storeSubscriptionsFinanceScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      SubscriptionsRoutes.SUBSCRIPTIONS_DUES_SCREEN: (context) =>
          storeSubscriptionsFinanceScreen,
      SubscriptionsRoutes.SUBSCRIPTIONS_DUES_DETAILS_SCREEN: (context) =>
          storeSubscriptionsFinanceDetailsScreen,
    };
  }
}
