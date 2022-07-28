import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/screens/new_order/update_order_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_actions_log_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_cash_captain_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_cash_store_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_pending_screen.dart';
import 'package:c4d/module_orders/ui/screens/orders_captain_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersModule extends YesModule {
  final OrderLogsScreen _logsScreen;
  final OrdersCashCaptainScreen _cashCaptain;
  final OrdersCashStoreScreen _cashStore;
  final OrderPendingScreen pendingScreen;
  final UpdateOrderScreen updateOrderScreen;
  final NewOrderScreen newOrderScreen;
  final OrderCaptainLogsScreen orderCaptainLogsScreen;
  final OrderActionLogsScreen orderActionLogsScreen;
  OrdersModule(
      this._logsScreen,
      this._cashCaptain,
      this._cashStore,
      this.updateOrderScreen,
      this.pendingScreen,
      this.newOrderScreen,
      this.orderCaptainLogsScreen,
      this.orderActionLogsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      OrdersRoutes.OWNER_LOGS_ORDERS_SCREEN: (context) => _logsScreen,
      OrdersRoutes.ORDER_CASH_STORES: (context) => _cashStore,
      OrdersRoutes.ORDER_CASH_CAPTAINS: (context) => _cashCaptain,
      OrdersRoutes.PENDING_ORDERS_SCREEN: (context) => pendingScreen,
      OrdersRoutes.UPDATE_ORDERS_SCREEN: (context) => updateOrderScreen,
      OrdersRoutes.NEW_ORDER_SCREEN: (context) => newOrderScreen,
      OrdersRoutes.CAPTAIN_ORDERS_SCREEN: (context) => orderCaptainLogsScreen,
      OrdersRoutes.ORDERS_ACTIONS_LOGS_SCREEN: (context) =>
          orderActionLogsScreen,
    };
  }
}
