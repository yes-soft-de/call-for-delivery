import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_bid_orders/bid_orders_routes.dart';
import 'package:c4d/module_bid_orders/model/order/order_model.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/ongoing_order_screen.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/open_orders_screen.dart';
import 'package:c4d/module_bid_orders/ui/widgets/bid_order_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:flutter/material.dart';

class OnGoingOrdersStateLoaded extends States {
  final List<OrderModel> orders;
  final OnGoingOrdersScreenState screenState;
  OnGoingOrdersStateLoaded(
    this.screenState, {
    required this.orders,
  }) : super(screenState) {
  }
  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders());
  }

  List<Widget> getOrders() {
    var context = screenState.context;
    List<Widget> widgets = [];
    orders.forEach((element) {
      widgets.add(Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, BidOrdersRoutes.ORDER_DETAILS_SCREEN,arguments:{'id' : element.id ,'onGoing':true} );
          },
          child:BidOrderCard(element,false),
        ),
      ));
    });
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }
}
