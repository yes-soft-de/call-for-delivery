import 'package:c4d/module_bid_order/bid_order_routes.dart';
import 'package:c4d/module_bid_order/ui/screen/bid_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

@injectable
class BidOrderModule extends YesModule {
  BidOrderModule(
  ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      BidOrderRoutes.BID_ORDER: (context) => BidOrdersScreen(),
    };
  }
}
