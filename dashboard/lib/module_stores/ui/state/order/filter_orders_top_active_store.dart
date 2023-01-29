import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_stores/ui/screen/order/order_top_active_store.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:c4d/module_stores/ui/widget/orders/owner_order_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';

import '../../../../module_orders/model/order/order_model.dart';

class FilterOrderLoadedState extends States {
  OrdersTopActiveStoreScreenState screenState;
  List<OrderModel> orders;
  FilterOrderLoadedState(this.screenState, this.orders) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders(context));
  }

  List<Widget> getOrders(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in orders) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              if (element.orderIsMain) {
                Navigator.of(screenState.context).pushNamed(
                    OrdersRoutes.SUB_ORDERS_SCREEN,
                    arguments: element.id);
              } else {
                Navigator.of(screenState.context).pushNamed(
                    StoresRoutes.ORDER_STATUS_SCREEN,
                    arguments: element.id);
              }
            },
            child: OwnerOrderCard(
              kilometer: element.kilometer > 0
                  ? FixedNumber.getFixedNumber(element.kilometer) +
                      ' ' +
                      S.current.km
                  : null,
              storeBranchToClientDistance:
                  element.storeBranchToClientDistance > 0
                      ? FixedNumber.getFixedNumber(
                              element.storeBranchToClientDistance) +
                          ' ' +
                          S.current.km
                      : null,
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
    }
    // if (screenState.currentIndex == 2) {
    //   widgets.insert(
    //       0,
    //       Center(
    //           child: Text(
    //         (widgets.length).toString() + ' ' + S.current.sOrder,
    //         style: TextStyle(
    //           fontSize: 17,
    //         ),
    //       )));
    // }
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }
}
