import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_ads/ads_routes.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_time_line_screen.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AdsModule extends YesModule {
  final OwnerOrdersScreen _ordersScreen;
  final OrderLogsScreen _logsScreen;
  final OrderTimeLineScreen _orderTimeLineScreen;
  AdsModule( this._ordersScreen,this._orderTimeLineScreen,
      this._logsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      AdsRoutes.NEW_ADS_SCREEN: (context) => _ordersScreen,
    };
  }
}
