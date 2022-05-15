import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart';
import 'package:c4d/module_orders/ui/widgets/home_widgets/order_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/fixed_numbers.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';

class SubOrdersListStateLoaded extends States {
  final List<OrderModel> orders;
  final SubOrdersScreenState screenState;
  SubOrdersListStateLoaded(
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
            child: OrderCard(
              primaryTitle: element.orderIsMain
                  ? S.current.primaryOrder
                  : S.current.suborder,
              orderNumber: element.id.toString(),
              orderStatus: StatusHelper.getOrderStatusMessages(element.state),
              deliveryDate: element.deliveryDate,
              orderIsMain: element.orderIsMain,
              background: element.orderIsMain
                  ? Colors.red[700]
                  : StatusHelper.getOrderStatusColor(element.state),
              note: element.note,
              orderCost: FixedNumber.getFixedNumber(element.orderCost),
              destination: S.current.destinationUnavailable == element.distance
                  ? element.distance
                  : S.current.distance +
                      ' ' +
                      element.distance +
                      ' ' +
                      S.current.km,
              credit: element.paymentMethod != 'cash',
            ),
          ),
        ),
      ));
    });
    widgets.add(const SizedBox(
      height: 75,
    ));
    return widgets;
  }
}
