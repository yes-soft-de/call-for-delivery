import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_time_line_screen.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersModule extends YesModule {
  final OwnerOrdersScreen _ordersScreen;
  final OrderLogsScreen _logsScreen;
  final OrderTimeLineScreen _orderTimeLineScreen;
  OrdersModule( this._ordersScreen,this._orderTimeLineScreen,
      this._logsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      OrdersRoutes.OWNER_ORDERS_SCREEN: (context) => _ordersScreen,
      OrdersRoutes.OWNER_LOGS_ORDERS_SCREEN: (context) => _logsScreen,
      OrdersRoutes.OWNER_TIME_LINE_SCREEN: (context) => _orderTimeLineScreen,
    };
  }
}
