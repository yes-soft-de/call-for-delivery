import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_bid_orders/bid_orders_routes.dart';
import 'package:c4d/module_bid_orders/ui/screens/order_logs_screen.dart';
import 'package:c4d/module_bid_orders/ui/screens/order_time_line_screen.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/my_offer_order_screen.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class BidOrdersModule extends YesModule {
  final OwnerOrdersScreen _ordersScreen;
  final OfferOrdersScreen _offerOrdersScreen;
  final OrderTimeLineScreen _orderTimeLineScreen;
  BidOrdersModule( this._ordersScreen,this._orderTimeLineScreen,
      this._offerOrdersScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      BidOrdersRoutes.OWNER_ORDERS_SCREEN: (context) => _ordersScreen,
      BidOrdersRoutes.OFFER_ORDERS_SCREEN: (context) => _offerOrdersScreen,
    };
  }
}
