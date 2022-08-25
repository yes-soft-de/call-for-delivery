import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/order_cash_request.dart';
import 'package:c4d/module_orders/ui/screens/orders_cash_screen.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_cash_card.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:flutter/material.dart';

class OrdersCashLoadedState extends States {
  OrdersCashScreenState screenState;
  List<OrderModel> orders;
  OrdersCashLoadedState(this.screenState, this.orders) : super(screenState);

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
          key: ObjectKey(element),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              if (element.orderIsMain == true && element.orders.isNotEmpty) {
                Navigator.of(screenState.context).pushNamed(
                    OrdersRoutes.SUB_ORDERS_SCREEN,
                    arguments: element.id);
              } else {
                Navigator.of(screenState.context).pushNamed(
                    OrdersRoutes.ORDER_STATUS_SCREEN,
                    arguments: element.id);
              }
            },
            child: OrderCashCard(
              orderNumber: element.id.toString(),
              createdDate: element.createdDate,
              deliveryDate: element.deliveryDate,
              orderCost: element.orderCost,
              answer: (paid) {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return CustomAlertDialog(
                        content: S.current.confirmOrderCashAnswer,
                        onPressed: () {
                          Navigator.of(context).pop();
                          screenState.manager.confirmOrderCashFinance(
                              screenState,
                              OrderCashRequest(
                                orderID: element.id,
                                paid: paid,
                              ));
                        },
                      );
                    });
              },
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
