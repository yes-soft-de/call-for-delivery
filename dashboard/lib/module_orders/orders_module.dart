import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_link.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/screens/new_order/update_order_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_actions_log_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_cash_captain_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_cash_store_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_conflict_distance_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_pending_screen.dart';
import 'package:c4d/module_orders/ui/screens/orders_captain_screen.dart';
import 'package:c4d/module_orders/ui/screens/search_for_order_screen.dart';
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'ui/screens/recycle_order/recycle_order_screen.dart';

@injectable
class OrdersModule extends YesModule {
  OrdersModule() {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      OrdersRoutes.ORDER_CASH_STORES: (context) => OrdersCashStoreScreen(),
      OrdersRoutes.ORDER_CASH_CAPTAINS: (context) => OrdersCashCaptainScreen(),
      OrdersRoutes.PENDING_ORDERS_SCREEN: (context) => OrderPendingScreen(),
      OrdersRoutes.UPDATE_ORDERS_SCREEN: (context) => UpdateOrderScreen(),
      OrdersRoutes.NEW_ORDER_SCREEN: (context) => NewOrderScreen(),
      OrdersRoutes.CAPTAIN_ORDERS_SCREEN: (context) => OrderCaptainLogsScreen(),
      OrdersRoutes.ORDERS_ACTIONS_LOGS_SCREEN: (context) =>
          OrderActionLogsScreen(),
      OrdersRoutes.ORDERS_RECEIVE_CASH: (context) => OrderActionLogsScreen(),
      OrdersRoutes.SUB_ORDERS_SCREEN: (context) => SubOrdersScreen(),
      OrdersRoutes.NEW_SUB_ORDER_SCREEN: (context) => NewOrderLinkScreen(),
      OrdersRoutes.SEARCH_FOR_ORDERS_SCREEN: (context) =>
          SearchForOrderScreen(),
      OrdersRoutes.RECYCLE_ORDERS_SCREEN: (context) => RecycleOrderScreen(),
      OrdersRoutes.ORDER_CONFLICT_DISTANCE_SCREEN: (context) =>
          OrderDistanceConflictScreen(),
    };
  }
}
