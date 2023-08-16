import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_bid_order/model/order/order_model.dart';
import 'package:c4d/module_bid_order/ui/screen/bid_orders_screen.dart';
import 'package:c4d/module_bid_order/ui/widget/bid_order_card.dart';
import 'package:flutter/material.dart';

class BidOrdersListStateLoaded extends States {
  final List<OrderModel> orders;
  final BidOrdersScreenState screenState;
  BidOrdersListStateLoaded(
    this.screenState, {
    required this.orders,
  }) : super(screenState) {}
  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: orders.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    //            Navigator.pushNamed(context, BidOrdersRoutes.ORDER_DETAILS_SCREEN,arguments:{'id' : element.id ,'onGoing':false} );
                  },
                  child: BidOrderCard(orders[index], true),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 75,
        )
      ],
    );
  }
}
