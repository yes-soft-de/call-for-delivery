import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_without_actions.dart';
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart';
import 'package:c4d/module_orders/ui/screens/terms/terms.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersModule extends RoutingModule {
  OrdersModule() {
    RoutingModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      OrdersRoutes.ORDER_STATUS_SCREEN: (context) => const OrderStatusScreen(),
      OrdersRoutes.CAPTAIN_ORDERS_SCREEN: (context) =>
          const CaptainOrdersScreen(),
      OrdersRoutes.TERMS_SCREEN: (context) => const TermsScreen(),
      OrdersRoutes.ORDER_LOGS: (context) => const OrderLogsScreen(),
      OrdersRoutes.SUB_ORDERS_SCREEN: (context) => const SubOrdersScreen(),
      OrdersRoutes.ORDER_STATUS_WITHOUT_ACTIONS_SCREEN: (context) =>
          const OrderStatusWithoutActionsScreen(),
    };
  }
}
