import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_orders/ui/screens/terms/terms.dart';

@injectable
class OrdersModule extends YesModule {
  final OrderStatusScreen _orderStatus;
  final CaptainOrdersScreen _captainOrdersScreen;
  final TermsScreen _termsScreen;
  final OrderLogsScreen _orderLogsScreen;
  OrdersModule(this._orderStatus, this._captainOrdersScreen, this._termsScreen,
      this._orderLogsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      OrdersRoutes.ORDER_STATUS_SCREEN: (context) => _orderStatus,
      OrdersRoutes.CAPTAIN_ORDERS_SCREEN: (context) => _captainOrdersScreen,
      OrdersRoutes.TERMS_SCREEN: (context) => _termsScreen,
      OrdersRoutes.ORDER_LOGS: (context) => _orderLogsScreen
    };
  }
}
