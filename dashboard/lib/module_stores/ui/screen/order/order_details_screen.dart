import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/widgets/update_order_status_form.dart';
import 'package:c4d/module_stores/model/order/order_model.dart';
import 'package:c4d/module_stores/state_manager/order/order_status.state_manager.dart';
import 'package:c4d/module_stores/ui/state/order/order_details_state_owner_order_loaded.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void deleteOrder(model) {}
  OrderStatusStateManager get manager => widget._stateManager;
  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void sendOrderReportState(var orderId, bool answar) {}

  void sendState(bool success) {
    if (success) {
      Flushbar(
        title: S.of(context).warnning,
        message: 'S.of(context).sendToRecordSuccess',
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      )..show(context);
    } else {
      Flushbar(
        title: S.of(context).warnning,
        message: 'S.of(context).sendToRecordFaild',
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  void goBack(String error) {
    Flushbar(
      title: S.of(context).errorHappened,
      message: error,
      icon: Icon(
        Icons.info,
        size: 28.0,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void requestOrderProgress() {}

  void getOrderDetails(var orderId) {}

  void changeStateToLoaded(OrderModel order) {
    if (mounted) {
      setState(() {});
    }
  }

  void rateCaptain() {}

  bool flag = true;
  bool canRemoveOrder = false;
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
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.orderDetails,
            actions: [
              Visibility(
                visible: currentState is OrderDetailsStateOwnerOrderLoaded &&
                    (currentState as OrderDetailsStateOwnerOrderLoaded)
                            .orderInfo
                            .state !=
                        OrderStatusEnum.CANCELLED,
                child: CustomC4dAppBar.actionIcon(context,
                    icon: Icons.rotate_left_rounded, onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return StatefulBuilder(builder: (ctx, refreshFul) {
                          return UpdateOrderStatusForm(
                            callBack: (request) {
                              widget._stateManager
                                  .updateOrderStatus(this, request);
                            },
                            orderInfo: (currentState
                                    as OrderDetailsStateOwnerOrderLoaded)
                                .orderInfo,
                          );
                        });
                      });
                }),
              ),
              Visibility(
                visible: currentState is OrderDetailsStateOwnerOrderLoaded &&
                    StatusHelper.getOrderStatusIndex(
                            (currentState as OrderDetailsStateOwnerOrderLoaded)
                                .orderInfo
                                .state) <
                        StatusHelper.getOrderStatusIndex(
                            OrderStatusEnum.FINISHED) &&
                    (currentState as OrderDetailsStateOwnerOrderLoaded)
                            .orderInfo
                            .state !=
                        OrderStatusEnum.CANCELLED,
                child: CustomC4dAppBar.actionIcon(context, onTap: () {
                  var s = currentState as OrderDetailsStateOwnerOrderLoaded;
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return CustomAlertDialog(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  OrdersRoutes.UPDATE_ORDERS_SCREEN,
                                  (route) => false,
                                  arguments: s.orderInfo);
                            },
                            content: S.current.updateOrderWarning,
                            oneAction: false);
                      });
                }, icon: Icons.edit),
              )
            ]),
        floatingActionButton: Visibility(
          visible: canRemoveOrder,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.error,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return CustomAlertDialog(
                      content: S.current.areYouSureAboutDeleteOrder,
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget._stateManager.deleteOrder(orderId, this);
                      },
                      oneAction: false,
                    );
                  });
            },
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        body: currentState.getUI(context),
      ),
    );
  }
}
