import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_average.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';

class OrdersListStateOrdersLoaded extends States {
  final List<OrderModel> orders;
  final OwnerOrdersScreenState screenState;
  OrdersListStateOrdersLoaded(
    this.screenState, {
    required this.orders,
  }) : super(screenState) {
    if (screenState.status?.consumingAlert == true) {
      showDialog(
          context: screenState.context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              title: Text(S.current.warnning),
              content: Container(
                height: 125,
                child: SingleChildScrollView(
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${S.of(context).dear} ${screenState.currentProfile?.name}',
                        textAlign: TextAlign.start,
                      ),
                      Container(
                        height: 4,
                      ),
                      Text(
                        OrderAverageHelper.getOrderAlertAverage(
                            screenState.status?.percentageOfOrdersConsumed ??
                                '0%'),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      screenState.getInitData();
                    },
                    child: Text(S.of(context).confirm)),
              ],
            );
          });
    }
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders(context));
  }

  List<Widget> getOrders(context) {
    // var context = screenState.context;
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
            child: OwnerOrderCard(
              isHide: element.isHide,
              orderNumber: element.id.toString(),
              orderStatus: StatusHelper.getOrderStatusMessages(element.state),
              createdDate: element.createdDate,
              deliveryDate: element.deliveryDate,
              orderIsMain: element.orderIsMain,
              background: screenState.currentIndex == 0
                  ? (element.orderIsMain ? Colors.red[700] : null)
                  : StatusHelper.getOrderStatusColor(element.state),
              orderCost: element.orderCost,
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
