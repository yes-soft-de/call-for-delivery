import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_subscription/subscriptions_routes.dart';
import 'package:c4d/module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class InitAccountModule extends YesModule {
  final InitSubscriptionScreen _initSubscriptionsScreen;
  InitAccountModule(this._initSubscriptionsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      InitSubscriptionsRoutes.INIT_SUBSCRIPTIONS_SCREEN: (context) => _initSubscriptionsScreen,
   };
  }
}
