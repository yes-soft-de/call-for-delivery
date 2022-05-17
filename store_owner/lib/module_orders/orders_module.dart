import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/hidden_orders_screen.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/screens/new_order_link.dart';
import 'package:c4d/module_orders/ui/screens/order_details/order_details_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_recylcing_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_time_line_screen.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersModule extends YesModule {
  final OwnerOrdersScreen _ordersScreen;
  final NewOrderScreen _newOrderScreen;
  final OrderDetailsScreen _orderStatus;
  final OrderLogsScreen _logsScreen;
  final OrderTimeLineScreen _orderTimeLineScreen;
  final NewOrderLinkScreen _newOrderLinkScreen;
  final SubOrdersScreen _subOrdersScreen;
  final HiddenOrdersScreen _hiddenOrdersScreen;
  final OrderRecyclingScreen _recyclingScreen;
  OrdersModule(
      this._newOrderScreen,
      this._orderStatus,
      this._ordersScreen,
      this._subOrdersScreen,
      this._newOrderLinkScreen,
      this._orderTimeLineScreen,
      this._logsScreen,
      this._hiddenOrdersScreen,
      this._recyclingScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      OrdersRoutes.NEW_ORDER_SCREEN: (context) => _newOrderScreen,
      OrdersRoutes.OWNER_ORDERS_SCREEN: (context) => _ordersScreen,
      OrdersRoutes.ORDER_STATUS_SCREEN: (context) => _orderStatus,
      OrdersRoutes.OWNER_LOGS_ORDERS_SCREEN: (context) => _logsScreen,
      OrdersRoutes.OWNER_TIME_LINE_SCREEN: (context) => _orderTimeLineScreen,
      OrdersRoutes.NEW_SUB_ORDER_SCREEN: (context) => _newOrderLinkScreen,
      OrdersRoutes.SUB_ORDERS_SCREEN: (context) => _subOrdersScreen,
      OrdersRoutes.OWNER_HIDDEN_ORDERS_SCREEN: (context) => _hiddenOrdersScreen,
      OrdersRoutes.ORDER_OWNER_RECYCLE: (context) => _recyclingScreen,
    };
  }
}
