import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_bidorder/bid_orders_routes.dart';
import 'package:c4d/module_bidorder/ui/screens/add_bidorder_screen.dart';
import 'package:c4d/module_bidorder/ui/screens/bidorder_details/bidorder_details_screen.dart';
import 'package:c4d/module_bidorder/ui/screens/bidorder_logs_screen.dart';
import 'package:c4d/module_bidorder/ui/screens/open_bidorder_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'ui/screens/bidorder_details/order_offer_details_screen.dart';

@injectable
class BidOrdersModule extends YesModule {
  final OpenBidOrderScreen _ordersScreen;
  final AddBidOrderScreen _newOrderScreen;
  final OrderOfferDetailsScreen _orderOfferDetailsScreen;
  final BidOrderLogsScreen _logsScreen;
  final BidOrderDetailsScreen _orderStatus;
//  final OrderTimeLineScreen _orderTimeLineScreen;
  BidOrdersModule( this._ordersScreen,this._newOrderScreen, this._orderOfferDetailsScreen, this._logsScreen, this._orderStatus
     ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      BidOrdersRoutes.NEW_ORDER_SCREEN: (context) => _newOrderScreen,
      BidOrdersRoutes.OPEN_ORDERS_SCREEN: (context) => _ordersScreen,
      BidOrdersRoutes.ORDER_OFFERS_SCREEN: (context) => _orderOfferDetailsScreen,
      BidOrdersRoutes.LOGS_BID_ORDERS_SCREEN: (context) => _logsScreen,
      BidOrdersRoutes.BID_ORDER_STATUS_SCREEN: (context) => _orderStatus,
//      OrdersRoutes.OWNER_TIME_LINE_SCREEN: (context) => _orderTimeLineScreen,
    };
  }
}
