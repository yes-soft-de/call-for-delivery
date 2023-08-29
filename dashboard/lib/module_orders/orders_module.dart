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
import 'package:c4d/module_orders/ui/screens/orders_receive_cash_screen.dart';
import 'package:c4d/module_orders/ui/screens/orders_without_distance_screen.dart';
import 'package:c4d/module_orders/ui/screens/search_for_order_screen.dart';
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'ui/screens/recycle_order/recycle_order_screen.dart';

@injectable
class OrdersModule extends YesModule {
  final OrdersCashCaptainScreen _cashCaptain;
  final OrdersCashStoreScreen _cashStore;
  final OrderPendingScreen pendingScreen;
  final UpdateOrderScreen updateOrderScreen;
  final NewOrderScreen newOrderScreen;
  final OrderActionLogsScreen orderActionLogsScreen;
  final OrdersReceiveCashScreen ordersReceiveCashScreen;
  final SubOrdersScreen subOrdersScreen;
  final NewOrderLinkScreen addNewOrderLinkScreen;
  final SearchForOrderScreen searchForOrderScreen;
  final RecycleOrderScreen recycleOrdersScreen; 
  final OrderDistanceConflictScreen orderDistanceConflictScreen;

  OrdersModule(
    this._cashCaptain,
    this._cashStore,
    this.updateOrderScreen,
    this.pendingScreen,
    this.newOrderScreen,
    this.orderActionLogsScreen,
    this.ordersReceiveCashScreen,
    this.subOrdersScreen,
    this.addNewOrderLinkScreen,
    this.searchForOrderScreen,
    this.recycleOrdersScreen,
    this.orderDistanceConflictScreen,
  ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      OrdersRoutes.ORDER_CASH_STORES: (context) => _cashStore,
      OrdersRoutes.ORDER_CASH_CAPTAINS: (context) => _cashCaptain,
      OrdersRoutes.PENDING_ORDERS_SCREEN: (context) => pendingScreen,
      OrdersRoutes.UPDATE_ORDERS_SCREEN: (context) => updateOrderScreen,
      OrdersRoutes.NEW_ORDER_SCREEN: (context) => newOrderScreen,
      OrdersRoutes.CAPTAIN_ORDERS_SCREEN: (context) => OrderCaptainLogsScreen(),
      OrdersRoutes.ORDERS_ACTIONS_LOGS_SCREEN: (context) =>
          orderActionLogsScreen,
      OrdersRoutes.ORDERS_RECEIVE_CASH: (context) => orderActionLogsScreen,
      OrdersRoutes.SUB_ORDERS_SCREEN: (context) => subOrdersScreen,
      OrdersRoutes.NEW_SUB_ORDER_SCREEN: (context) => addNewOrderLinkScreen,
      OrdersRoutes.SEARCH_FOR_ORDERS_SCREEN: (context) => searchForOrderScreen,
      OrdersRoutes.RECYCLE_ORDERS_SCREEN: (context) => recycleOrdersScreen,
      OrdersRoutes.ORDER_CONFLICT_DISTANCE_SCREEN: (context) =>
          orderDistanceConflictScreen,
    };
  }
}
