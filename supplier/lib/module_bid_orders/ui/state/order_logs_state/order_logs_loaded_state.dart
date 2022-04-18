import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_bid_orders/bid_orders_routes.dart';
import 'package:c4d/module_bid_orders/model/order/order_model.dart';
import 'package:c4d/module_bid_orders/ui/screens/order_logs_screen.dart';
import 'package:c4d/module_bid_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';

class OrderLogsLoadedState extends States {
  OrderLogsScreenState screenState;
  List<OrderModel> orders;
  OrderLogsLoadedState(this.screenState, this.orders) : super(screenState);

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
              Navigator.of(screenState.context).pushNamed(
                  BidOrdersRoutes.ORDER_STATUS_SCREEN,
                  arguments: element.id);
            },
            child: OwnerOrderCard(
              orderNumber: element.id.toString(),
              orderStatus: StatusHelper.getOrderStatusMessages(element.state),
              createdDate: element.createdDate,
              deliveryDate: element.deliveryDate,
              orderCost:element.orderCost,
              note: element.note,
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
