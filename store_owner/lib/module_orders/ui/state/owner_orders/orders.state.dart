import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:c4d/module_orders/ui/widgets/filter_bar.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';

class OrdersListStateOrdersLoaded extends States {
  final List<OrderModel> orders;
  final OwnerOrdersScreenState screenState;
  OrdersListStateOrdersLoaded(
    this.screenState, {
    required this.orders,
  }) : super(screenState);
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
                  OrdersRoutes.ORDER_STATUS_SCREEN,
                  arguments: element.id);
            },
            child: OwnerOrderCard(
              orderNumber: element.id.toString(),
              orderStatus: StatusHelper.getOrderStatusMessages(element.state),
              createdDate: element.createdDate,
              deliveryDate: element.deliveryDate,
              orderCost:
                  element.orderCost.toStringAsFixed(2) + ' ' + S.current.sar,
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
