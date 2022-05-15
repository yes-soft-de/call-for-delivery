import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart';
import 'package:c4d/module_orders/ui/widgets/home_widgets/order_card.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/fixed_numbers.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubOrdersListStateLoaded extends States {
  final List<OrderModel> orders;
  final bool acceptedOrder;
  final SubOrdersScreenState screenState;
  SubOrdersListStateLoaded(this.screenState,
      {required this.orders, required this.acceptedOrder})
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders());
  }

  List<Widget> getOrders() {
    var context = screenState.context;
    List<Widget> widgets = [];
    if (acceptedOrder == false) {
      widgets.add(Flushbar(
        icon: const Icon(
          FontAwesomeIcons.info,
          color: Colors.white,
        ),
        backgroundColor: Colors.amber,
        message: S.current.youNeedToAcceptPrimaryOrderFirst,
      ));
    }
    for (var element in orders) {
      widgets.add(Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            if (element.orderIsMain) {
              Navigator.of(screenState.context).pushNamed(
                  OrdersRoutes.ORDER_STATUS_SCREEN,
                  arguments: element.id);
            } else if (acceptedOrder == false) {
              Navigator.of(screenState.context).pushNamed(
                  OrdersRoutes.ORDER_STATUS_WITHOUT_ACTIONS_SCREEN,
                  arguments: element.id);
            } else {
              Navigator.of(screenState.context).pushNamed(
                  OrdersRoutes.ORDER_STATUS_SCREEN,
                  arguments: element.id);
            }
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
      ));
      if (widgets.length > 1 &&
          element.state == OrderStatusEnum.WAITING &&
          acceptedOrder) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            children: [
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {
                    String? state;
                    if (orders[0].state == OrderStatusEnum.GOT_CAPTAIN) {
                      state = StatusHelper.getStatusString(
                          OrderStatusEnum.GOT_CAPTAIN);
                    } else {
                      state = StatusHelper.getStatusString(
                          OrderStatusEnum.DELIVERING);
                    }
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                              onPressed: () {
                                Navigator.of(context).pop();
                                screenState.manager.updateOrderState(
                                    screenState,
                                    UpdateOrderRequest(
                                        id: element.id, state: state));
                              },
                              content: S.current.confirmAcceptSubOrder);
                        });
                  },
                  icon: const Icon(Icons.thumb_up_alt),
                  label: Text(S.current.accept)),
              const Spacer(),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                              onPressed: () {
                                Navigator.of(context).pop();
                                screenState.manager.removeSubOrder(screenState,
                                    OrderNonSubRequest(orderID: element.id));
                              },
                              content: S.current.confirmRemoveSubOrder);
                        });
                  },
                  icon: const Icon(Icons.thumb_down_alt),
                  label: Text(S.current.reject))
            ],
          ),
        ));
      }
    }
    widgets.add(const SizedBox(
      height: 75,
    ));
    return widgets;
  }
}
