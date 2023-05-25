import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order_without_distance_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/orders_without_distance_screen.dart';
import 'package:c4d/module_orders/ui/widgets/orders_without_distance/order_without_distance_card.dart';
import 'package:c4d/module_orders/ui/widgets/orders_without_distance/update_distance_dialog.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class OrderWithoutDistanceLoadedState extends States {
  OrdersWithoutDistanceScreenState screenState;
  OrdersWithoutDistanceModel orders;
  OrderWithoutDistanceLoadedState(this.screenState, this.orders)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders(context));
  }

  List<Widget> getOrders(context) {
    List<Widget> widgets = [];
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
            child: OrderWithoutDistance(
              orderNumber: element.id.toString(),
              orderStatus: StatusHelper.getOrderStatusMessages(element.state),
              createdDate: element.createdDate,
              deliveryDate: element.deliveryDate,
              orderCost: element.orderCost,
              branchLocation: element.branchLocation ?? LatLng(0, 0),
              destinationUrl: element.destinationLink ?? '',
              onEdit: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        scrollable: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        title: Text(S.current.updateDistance),
                        content: UpdateDistanceDialog(
                          branchLocation:
                              element.branchLocation ?? LatLng(0, 0),
                          callback: (request) {
                            screenState.updateDistance(request);
                          },
                          id: element.id,
                        ),
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
