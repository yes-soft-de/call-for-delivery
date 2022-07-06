import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_details_state_owner_order_loaded.dart';
import 'package:c4d/module_orders/ui/widgets/custom_remove_sub_order_dialog.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:c4d/utils/request/rating_request.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;

@injectable
class OrderDetailsScreen extends StatefulWidget {
  final OrderStatusStateManager _stateManager;
  OrderDetailsScreen(this._stateManager);

  @override
  OrderDetailsScreenState createState() => OrderDetailsScreenState();
}

class OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int orderId = -1;
  late States currentState;
  bool alertFlag = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  OrderStatusStateManager get manager => widget._stateManager;
  void deleteOrder() {
    widget._stateManager.deleteOrder(orderId, this);
  }

  LatLng? myLocation;
  @override
  void initState() {
    currentState = LoadingState(this);
    DeepLinksService.defaultLocation().then((value) {
      if (value != null) {
        myLocation = value;
        Logger().info(
            'Location with us ', myLocation?.toJson().toString() ?? 'null');
        if (mounted) {
          setState(() {});
        }
      }
    });
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
      if (mounted) {
        if (orderId != -1) {
          widget._stateManager.getOrder(this, orderId, false);
        }
      }
    });
    super.initState();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void rateCaptain(RatingRequest request) {
    widget._stateManager.rateCaptain(this, request);
  }

  bool canRemoveIt = false;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && currentState is LoadingState && flag) {
      orderId = args as int;
      widget._stateManager.getOrder(this, orderId);
      flag = false;
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomC4dAppBar
              .appBar(context, title: S.current.orderDetails, actions: [
            Visibility(
              visible: currentState is OrderDetailsStateOwnerOrderLoaded &&
                  (currentState as OrderDetailsStateOwnerOrderLoaded)
                      .orderInfo
                      .orderIsMain &&
                  (currentState as OrderDetailsStateOwnerOrderLoaded)
                          .orderInfo
                          .state !=
                      OrderStatusEnum.FINISHED,
              child: CustomC4dAppBar.actionIcon(context,
                  message: S.current.newOrderLink, onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return CustomAlertDialog(
                          onPressed: () {
                            var order = (currentState
                                    as OrderDetailsStateOwnerOrderLoaded)
                                .orderInfo;

                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(
                                OrdersRoutes.NEW_SUB_ORDER_SCREEN,
                                arguments: OrderModel(
                                    branchID: order.branchID,
                                    branchName: order.branchName,
                                    state: order.state,
                                    orderCost: order.orderCost,
                                    note: order.branchName,
                                    deliveryDate: order.branchName,
                                    createdDate: order.branchName,
                                    id: order.id,
                                    orderType: 1,
                                    orderIsMain: order.orderIsMain,
                                    orders: order.subOrders,
                                    isHide: 0));
                          },
                          content: S.current.areYouSureAboutCreatingSubOrder);
                    });
              }, icon: Icons.link),
            ),
            Visibility(
              visible: currentState is OrderDetailsStateOwnerOrderLoaded &&
                  (currentState as OrderDetailsStateOwnerOrderLoaded)
                      .orderInfo
                      .orderIsMain &&
                  (currentState as OrderDetailsStateOwnerOrderLoaded)
                      .orderInfo
                      .subOrders
                      .isNotEmpty &&
                  (currentState as OrderDetailsStateOwnerOrderLoaded)
                          .orderInfo
                          .state !=
                      OrderStatusEnum.FINISHED,
              child: CustomC4dAppBar.actionIcon(context,
                  message: S.current.unlinkSubOrders, onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return RemoveSubOrderDialog(
                        primaryOrder: orderId,
                        orders:
                            (currentState as OrderDetailsStateOwnerOrderLoaded)
                                .orderInfo
                                .subOrders,
                        request: (request) {
                          manager.removeSubOrder(this, request);
                        },
                      );
                    });
              }, icon: Icons.link_off),
            ),
          ]),
          body: currentState.getUI(context),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                  visible: canRemoveIt,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return CustomAlertDialog(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  deleteOrder();
                                },
                                content: S.current.areYouSureAboutDeleteOrder);
                          });
                    },
                  )),
              SizedBox(
                width: 8,
              ),
              Visibility(
                visible: currentState is OrderDetailsStateOwnerOrderLoaded &&
                    (currentState as OrderDetailsStateOwnerOrderLoaded)
                            .orderInfo
                            .state !=
                        OrderStatusEnum.FINISHED &&
                    (currentState as OrderDetailsStateOwnerOrderLoaded)
                            .orderInfo
                            .state !=
                        OrderStatusEnum.CANCELLED,
                child: FloatingActionButton(
                    tooltip: S.current.editOrder,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return CustomAlertDialog(
                              content: S.current.updateOrderWarning,
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    OrdersRoutes.ORDER_OWNER_UPDATE,
                                    (route) => false,
                                    arguments: (currentState
                                            as OrderDetailsStateOwnerOrderLoaded)
                                        .orderInfo);
                              },
                            );
                          });
                    },
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    )),
              )
            ],
          )),
    );
  }

  Future<bool> canRequestLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await loc.Location().requestService();
        if (!serviceEnabled) {
          return false;
        }
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
