import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_bidorder/model/order/order_model.dart';
import 'package:c4d/module_bidorder/ui/screens/open_bidorder_screen.dart';
import 'package:c4d/module_bidorder/ui/widget/bid_order_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:flutter/material.dart';

class OpenOrdersLoaded extends States {
  final List<BidOrderModel> orders;
  final OpenBidOrderScreenState screenState;
  OpenOrdersLoaded(
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
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
//              Navigator.of(screenState.context).pushNamed(
//                  OrdersRoutes.ORDER_STATUS_SCREEN,
//                  arguments: element.id);
            },
            child: BidOrderCard(
               model: element,
              isOpen: true,
            ),
          ),
        ),
      ));
    });
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }
}
