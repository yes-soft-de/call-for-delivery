import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_bid_orders/bid_orders_routes.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/my_offer_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'ui/screens/add_offer_screen.dart';
import 'ui/screens/order_logs_screen.dart';
import 'ui/screens/orders/ongoing_order_screen.dart';
import 'ui/screens/orders/order_details_screen.dart';
import 'ui/screens/orders/open_orders_screen.dart';

@injectable
class BidOrdersModule extends YesModule {
  final OpenOrdersScreen _ordersScreen;
  final OnGoingOrdersScreen _onGoingOrdersScreen;
  final OfferOrdersScreen _offerOrdersScreen;
  final OrderDetailsScreen _orderDetailsScreen;
  final OrderLogsScreen _orderLogsScreen;
  final AddOfferScreen _addOfferScreen;
  BidOrdersModule( this._ordersScreen,this._orderDetailsScreen,
      this._offerOrdersScreen,this._orderLogsScreen, this._onGoingOrdersScreen, this._addOfferScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      BidOrdersRoutes.OWNER_ORDERS_SCREEN: (context) => _ordersScreen,
      BidOrdersRoutes.OFFER_ORDERS_SCREEN: (context) => _offerOrdersScreen,
      BidOrdersRoutes.ORDER_DETAILS_SCREEN: (context) => _orderDetailsScreen,
      BidOrdersRoutes.ORDER_LOG: (context) => _orderLogsScreen,
      BidOrdersRoutes.ONGOING_ORDER: (context) => _onGoingOrdersScreen,
      BidOrdersRoutes.ADD_OFFER_SCREEN: (context) => _addOfferScreen,
    };
  }
}
