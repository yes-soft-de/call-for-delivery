import 'package:c4d/module_stores/ui/screen/order/order_time_line_screen.dart';
import 'package:c4d/module_stores/ui/screen/store_subscriptions_details_screen.dart';
import 'package:c4d/module_stores/ui/screen/store_subscriptions_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:c4d/module_payments/ui/screen/store_balance_screen.dart';
import 'package:c4d/module_stores/ui/screen/store_info_screen.dart';
import 'package:c4d/module_stores/ui/screen/stores_inactive_screen.dart';
import 'package:c4d/module_stores/ui/screen/stores_screen.dart';

import 'ui/screen/order/order_captain_not_arrived.dart';
import 'ui/screen/order/order_details_screen.dart';
import 'ui/screen/order/order_logs_screen.dart';
import 'ui/screen/stores_needs_support_screen.dart';

@injectable
class StoresModule extends YesModule {
  final StoresScreen storesScreen;
  final StoreInfoScreen _storeInfoScreen;
  final StoresInActiveScreen storesInActiveScreen;
  final StoreBalanceScreen storeBalanceScreen;
  final StoresNeedsSupportScreen supportScreen;
  final OrderDetailsScreen _orderStatus;
  final OrderLogsScreen _logsScreen;
  final StoreSubscriptionsFinanceScreen storeSubscriptionsFinanceScreen;
  final StoreSubscriptionsFinanceDetailsScreen
      storeSubscriptionsFinanceDetailsScreen;
  final OrderCaptainNotArrivedScreen captainNotArrivedScreen;
  final OrderTimeLineScreen orderTimeLineScreen;

  StoresModule(
      this.storesScreen,
      this._storeInfoScreen,
      this.storesInActiveScreen,
      this.storeBalanceScreen,
      this.supportScreen,
      this._orderStatus,
      this._logsScreen,
      this.captainNotArrivedScreen,
      this.orderTimeLineScreen,
      this.storeSubscriptionsFinanceDetailsScreen,
      this.storeSubscriptionsFinanceScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      StoresRoutes.STORES: (context) => storesScreen,
      StoresRoutes.STORE_INFO: (context) => _storeInfoScreen,
      StoresRoutes.STORES_INACTIVE: (context) => storesInActiveScreen,
      StoresRoutes.STORE_BALANCE: (context) => storeBalanceScreen,
      StoresRoutes.STORE_SUPPORT: (context) => supportScreen,
      StoresRoutes.ORDER_STATUS_SCREEN: (context) => _orderStatus,
      StoresRoutes.LOGS_ORDERS_SCREEN: (context) => _logsScreen,
      StoresRoutes.ORDER_TIMELINE_SCREEN: (context) => orderTimeLineScreen,
      StoresRoutes.ORDER_CAPTAIN_SCREEN: (context) => captainNotArrivedScreen,
      StoresRoutes.SUBSCRIPTIONS_DUES_SCREEN: (context) =>
          storeSubscriptionsFinanceScreen,
      StoresRoutes.SUBSCRIPTIONS_DUES_DETAILS_SCREEN: (context) =>
          storeSubscriptionsFinanceDetailsScreen,
    };
  }
}
