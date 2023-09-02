import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_payments/ui/screen/store_balance_screen.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:c4d/module_stores/ui/screen/edit_store_setting_screen.dart';
import 'package:c4d/module_stores/ui/screen/order/order_time_line_screen.dart';
import 'package:c4d/module_stores/ui/screen/order/order_top_active_store.dart';
import 'package:c4d/module_stores/ui/screen/store_info_screen.dart';
import 'package:c4d/module_stores/ui/screen/stores_dues/store_dues_screen.dart';
import 'package:c4d/module_stores/ui/screen/stores_dues/stores_dues_screen.dart';
import 'package:c4d/module_stores/ui/screen/stores_inactive_screen.dart';
import 'package:c4d/module_stores/ui/screen/stores_screen.dart';
import 'package:c4d/module_stores/ui/screen/top_active_store_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'ui/screen/order/order_captain_not_arrived.dart';
import 'ui/screen/order/order_details_screen.dart';
import 'ui/screen/order/order_logs_screen.dart';
import 'ui/screen/stores_needs_support_screen.dart';

@injectable
class StoresModule extends YesModule {
  StoresModule() {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      StoresRoutes.STORES: (context) => StoresScreen(),
      StoresRoutes.STORE_INFO: (context) => StoreInfoScreen(),
      StoresRoutes.STORES_INACTIVE: (context) => StoresInActiveScreen(),
      StoresRoutes.STORE_BALANCE: (context) => StoreBalanceScreen(),
      StoresRoutes.STORE_SUPPORT: (context) => StoresNeedsSupportScreen(),
      StoresRoutes.ORDER_STATUS_SCREEN: (context) => OrderDetailsScreen(),
      StoresRoutes.LOGS_ORDERS_SCREEN: (context) => OrderLogsScreen(),
      StoresRoutes.ORDER_TIMELINE_SCREEN: (context) => OrderTimeLineScreen(),
      StoresRoutes.ORDER_CAPTAIN_SCREEN: (context) =>
          OrderCaptainNotArrivedScreen(),
      StoresRoutes.TOP_STORE_ACTIVE: (context) => TopActiveStoreScreen(),
      StoresRoutes.ORDERS_TOP_STORE_ACTIVE: (context) =>
          OrdersTopActiveStoreScreen(),
      StoresRoutes.STORES_DUES_SCREEN: (context) => StoresDuesScreen(),
      StoresRoutes.STORE_DUES_SCREEN: (context) => StoreDuesScreen(),
      StoresRoutes.Edit_STORE_Setting_SCREEN: (context) =>
          EditStoreSettingScreen(),
    };
  }
}
