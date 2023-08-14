import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_orders/model/order_without_distance_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/add_extra_distance_request.dart';
import 'package:c4d/module_orders/ui/screens/orders_without_distance_screen.dart';
import 'package:c4d/module_orders/ui/widgets/orders_without_distance/add_distance_dialog.dart';
import 'package:c4d/module_orders/ui/widgets/orders_without_distance/order_without_distance_card.dart';
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
    return ListView.builder(
      itemCount: orders.orders.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                Navigator.of(screenState.context).pushNamed(
                    OrdersRoutes.ORDER_STATUS_SCREEN,
                    arguments: orders.orders[index].id);
              },
              child: OrderWithoutDistance(
                orderNumber: orders.orders[index].id.toString(),
                orderStatus: StatusHelper.getOrderStatusMessages(
                    orders.orders[index].state),
                createdDate: orders.orders[index].createdDate,
                deliveryDate: orders.orders[index].deliveryDate,
                orderCost: orders.orders[index].orderCost,
                branchLocation:
                    orders.orders[index].branchLocation ?? LatLng(0, 0),
                destinationUrl: orders.orders[index].destinationLink ?? '',
                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AddDistanceDialog(
                        onCoordinatesAdd: (coordinates) {
                          screenState.addCoordinates(AddExtraDistanceRequest(
                            id: orders.orders[index].id,
                            destination: Destination(
                              lat: coordinates.lat,
                              lon: coordinates.lon,
                            ),
                          ));
                        },
                        onKilometerAdd: (kilometer) {
                          screenState.addKilometer(AddExtraDistanceRequest(
                            id: orders.orders[index].id,
                            additionalDistance: kilometer.toDouble(),
                          ));
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
