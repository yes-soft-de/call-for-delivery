import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/add_extra_distance_request.dart';
import 'package:c4d/module_orders/ui/screens/order_conflict_distance_screen.dart';
import 'package:c4d/module_orders/ui/widgets/order_distance_conflict_card.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderDistanceConflictLoadedState extends States {
  OrderDistanceConflictScreenState screenState;
  List<OrderModel> orders;
  OrderDistanceConflictLoadedState(this.screenState, this.orders)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders(context));
  }

  List<Widget> getOrders(context) {
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
            child: OrderDistanceConflict(
              orderNumber: element.id.toString(),
              branchName: element.branchName,
              captain: element.captainName ?? S.current.unknown,
              distance: element.storeBranchToClientDistance.toDouble(),
              onEdit: () {
                final reason = TextEditingController();
                final coord = TextEditingController();
                final form_key = GlobalKey<FormState>();
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text(S.current.updateDistance),
                        content: SizedBox(
                          height: 175,
                          child: Form(
                            key: form_key,
                            child: Column(
                              children: [
                                CustomFormField(
                                  controller: coord,
                                  hintText:
                                      S.current.coordinates + ' 12.4,15.8',
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                CustomFormField(
                                  controller: reason,
                                  hintText: S.current.reason,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (form_key.currentState?.validate() ==
                                          true) {
                                        if (coord.text.split(',').length == 2) {
                                          Navigator.of(context).pop();
                                          screenState.manager.updateDistance(
                                              screenState,
                                              AddExtraDistanceRequest(
                                                  id: element.id,
                                                  storeBranchToClientDistanceAdditionExplanation:
                                                      reason.text.trim(),
                                                  destination:Destination(
                                                    lat: double.tryParse(coord.text
                                                        .trim()
                                                        .split(',')[0]
                                                        .trim()),
                                                    lon:  double.tryParse(coord.text
                                                        .trim()
                                                        .split(',')[1]
                                                        .trim()),
                                                  )));
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: S.current
                                                  .pleaseEnterValidCoord);
                                        }
                                      }
                                    },
                                    child: Text(S.current.update)),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              storeOwner: element.storeName ?? S.current.unknown,
              conflictReason:
                  element.storeBranchToClientDistanceAdditionExplanation,
              onEditExtra: () {
                final reason = TextEditingController();
                final distance = TextEditingController();
                final form_key = GlobalKey<FormState>();
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text(S.current.addExtraDestination),
                        content: SizedBox(
                          height: 175,
                          child: Form(
                            key: form_key,
                            child: Column(
                              children: [
                                CustomFormField(
                                  controller: distance,
                                  numbers: true,
                                  hintText: '14',
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                CustomFormField(
                                  controller: reason,
                                  hintText: S.current.reason,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (form_key.currentState?.validate() ==
                                          true) {
                                        if (double.tryParse(distance.text) !=
                                            null) {
                                          Navigator.of(context).pop();
                                          screenState.manager.addExtraDistance(
                                              screenState,
                                              AddExtraDistanceRequest(
                                                  id: element.id,
                                                  storeBranchToClientDistanceAdditionExplanation:
                                                      reason.text.trim(),
                                                  additionalDistance:
                                                      double.tryParse(
                                                          distance.text)));
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: S.current
                                                  .pleaseEnterValidCoord);
                                        }
                                      }
                                    },
                                    child: Text(S.current.update)),
                              ],
                            ),
                          ),
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
