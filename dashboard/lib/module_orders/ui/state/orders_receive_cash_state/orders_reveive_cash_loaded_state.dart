import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/orders_receive_cash_screen.dart';
import 'package:c4d/module_orders/ui/widgets/order_cash_widgets/order_cash_conflicting_card.dart';
import 'package:c4d/module_orders/ui/widgets/order_cash_widgets/owner_order_cash_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/finance_status_helper.dart';
import 'package:flutter/material.dart';

class OrdersReceiveCashLoadedState extends States {
  OrdersReceiveCashScreenState screenState;
  List<OrderModel> orders;
  OrdersReceiveCashLoadedState(this.screenState, this.orders)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders());
  }

  List<Widget> getOrders() {
    List<Widget> widgets = [];
    if (screenState.currentIndex == 0) {
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
              child: OrderCashCard(
                orderNumber: element.id.toString(),
                createdDate: element.createdDate,
                deliveryDate: element.deliveryDate,
                orderCost: element.orderCost,
                answer: (answer) {},
              ),
            ),
          ),
        ));
      });
    } else {
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
              child: OrderCashConflictCard(
                orderNumber: element.id.toString(),
                createdDate: element.createdDate,
                captainAnswer:
                    FinanceHelper.getStatusString(element.paidToProvider),
                storeAnswer: FinanceHelper.getStatusString(
                    element.isCashPaymentConfirmedByStore),
                captain: element.captainName ?? S.current.unknown,
                store: (element.storeName ?? '') + ' | ' + element.branchName,
              ),
            ),
          ),
        ));
      });
    }
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }
}
