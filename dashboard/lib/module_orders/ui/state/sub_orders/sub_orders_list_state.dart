import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
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
    return Column(
      children: [
        ListView.builder(
          itemCount: orders.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var element = orders[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                key: ObjectKey(element),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: () {
                    Navigator.of(screenState.context).pushNamed(
                        OrdersRoutes.ORDER_STATUS_SCREEN,
                        arguments: element.id);
                  },
                  child: OwnerOrderCard(
                    captainProfileId: element.captainProfileId,
                    primaryTitle: element.orderIsMain
                        ? S.current.primaryOrder
                        : S.current.suborder,
                    orderNumber: element.id.toString(),
                    orderStatus:
                        StatusHelper.getOrderStatusMessages(element.state),
                    createdDate: element.createdDate,
                    deliveryDate: element.deliveryDate,
                    orderIsMain: element.orderIsMain,
                    background: element.orderIsMain
                        ? Colors.red[700]
                        : StatusHelper.getOrderStatusColor(element.state),
                    orderCost: element.orderCost,
                    note: element.note,
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 75),
      ],
    );
  }
}
