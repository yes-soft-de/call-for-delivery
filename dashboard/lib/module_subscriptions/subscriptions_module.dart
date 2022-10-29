import 'package:c4d/module_subscriptions/subscriptions_routes.dart';
import 'package:c4d/module_subscriptions/ui/screen/edit_subscription_screen.dart';
import 'package:c4d/module_subscriptions/ui/screen/init_subscription_screen.dart';
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
  final StoreSubscriptionsFinanceScreen storeSubscriptionsFinanceScreen;
  final StoreSubscriptionsFinanceDetailsScreen
      storeSubscriptionsFinanceDetailsScreen;
  final SubscriptionManagementScreen subscriptionManagementScreen;
  final StoreSubscriptionsExpiredFinanceScreen
      subscriptionsExpiredFinanceScreen;
  final CreateSubscriptionScreen initSubscriptionScreen;
  final CreateSubscriptionToCaptainOfferScreen
      createSubscriptionToCaptainOfferScreen;
  final EditSubscriptionScreen editSubscriptionScreen;
  SubscriptionsModule(
    this.storeSubscriptionsFinanceDetailsScreen,
    this.storeSubscriptionsFinanceScreen,
    this.subscriptionManagementScreen,
    this.subscriptionsExpiredFinanceScreen,
    this.initSubscriptionScreen,
    this.createSubscriptionToCaptainOfferScreen,
    this.editSubscriptionScreen,
  ) {
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
      SubscriptionsRoutes.CREATE_NEW_SUBSCRIPTION_SCREEN: (context) =>
          initSubscriptionScreen,
      SubscriptionsRoutes.EDIT_SUBSCRIPTION_SCREEN: (context) =>
          editSubscriptionScreen,
      SubscriptionsRoutes.CREATE_NEW_SUBSCRIPTION_TO_CAPTAIN_OFFER_SCREEN:
          (context) => createSubscriptionToCaptainOfferScreen,
    };
  }
}
