import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order_captain_logs_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/orders_captain_screen.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderCaptainLogsLoadedState extends States {
  OrderCaptainLogsScreenState screenState;
  OrderCaptainLogsModel orders;
  OrderCaptainLogsLoadedState(this.screenState, this.orders)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders());
  }

  List<Widget> getOrders() {
    var context = screenState.context;
    List<Widget> widgets = [];
    widgets.add(Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Icon(
                  FontAwesomeIcons.boxes,
                  color: Theme.of(context).disabledColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                  child: Text(
                    S.current.countOrders,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                    child: Text(
                  orders.countOrders.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).disabledColor,
                      fontWeight: FontWeight.bold),
                ))
              ],
            ),
          ),
        ),
        Visibility(
          visible: orders.cashOrder != null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    FontAwesomeIcons.boxes,
                    color: Theme.of(context).disabledColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                    child: Text(
                      S.current.totalCashOrder,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                      child: Text(
                    FixedNumber.getFixedNumber(orders.cashOrder ?? 0) +
                        ' ' +
                        S.current.sar,
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.bold),
                  ))
                ],
              ),
            ),
          ),
        )
      ],
    ));
    orders.orders.forEach((element) {
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
              orderCost: element.orderCost,
              note: element.note,
              orderIsMain: false,
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
