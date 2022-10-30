import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/model/order_without_distance_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/update_distance_request.dart';
import 'package:c4d/module_orders/ui/screens/orders_without_distance_screen.dart';
import 'package:c4d/module_orders/ui/widgets/geo_widget.dart';
import 'package:c4d/module_orders/ui/widgets/orders_without_distance/order_without_distance_card.dart';
import 'package:c4d/module_stores/response/order/orders_response/destination.dart';
import 'package:c4d/utils/components/custom_feild.dart';
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
                var _kilometer = TextEditingController();
                num? distance = null;
                showDialog(
                    context: context,
                    builder: (ctx) {
                      LatLng? coordinations;
                      return StatefulBuilder(builder: (context, setState) {
                        return AlertDialog(
                          scrollable: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          title: Text(S.current.updateDistance),
                          content: Container(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                      S.current.provideClientCoordinations),
                                  subtitle: CustomFormField(
                                    onChanged: () {
                                      var coord = _kilometer.text.split(',');
                                      if (coord.length == 2) {
                                        coordinations = LatLng(
                                            double.tryParse(coord[0].trim()) ??
                                                0,
                                            double.tryParse(coord[1].trim()) ??
                                                0);
                                      }
                                      setState(() {});
                                    },
                                    controller: _kilometer,
                                    hintText: S
                                        .current.provideClientCoordinationsHint,
                                  ),
                                ),
                                Visibility(
                                    visible: coordinations != null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.amber),
                                        child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: GeoDistanceText(
                                              destination:
                                                  coordinations ?? LatLng(0, 0),
                                              origin: element.branchLocation ??
                                                  LatLng(0, 0),
                                              destance: (d) {
                                                distance =
                                                    num.tryParse(d ?? '');
                                                setState(() {});
                                              },
                                              storeID: -1,
                                            )),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            ElevatedButton(
                                onPressed: distance == null ||
                                        coordinations == null
                                    ? null
                                    : () {
                                        Navigator.of(ctx).pop();
                                        screenState.updateDistance(
                                            UpdateDistanceRequest(
                                          id: element.id,
                                          storeBranchToClientDistance: distance,
                                          destination: Destination(
                                              lat: coordinations?.latitude,
                                              lon: coordinations?.longitude,
                                              link: element.destinationLink),
                                        ));
                                        _kilometer.clear();
                                      },
                                child: Text(
                                  S.current.confirm,
                                  style: Theme.of(context).textTheme.button,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  _kilometer.clear();
                                },
                                child: Text(
                                  S.current.cancel,
                                  style: Theme.of(context).textTheme.button,
                                ))
                          ],
                        );
                      });
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
