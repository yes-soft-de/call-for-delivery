import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state_manager/sub_orders_list_state_manager.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_details_state_owner_order_loaded.dart';
import 'package:c4d/module_orders/ui/widgets/custom_remove_sub_order_dialog.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:c4d/utils/request/rating_request.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubOrdersScreen extends StatefulWidget {
  final SubOrdersStateManager _stateManager;
  SubOrdersScreen(this._stateManager);

  @override
  SubOrdersScreenState createState() => SubOrdersScreenState();
}

class SubOrdersScreenState extends State<SubOrdersScreen> {
  int orderId = -1;
  late States currentState;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SubOrdersStateManager get manager => widget._stateManager;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
      if (mounted) {
        widget._stateManager.getOrder(this, orderId, false);
      }
    });
    super.initState();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
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
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.groupOrder,
            actions: [
              Visibility(
                visible: currentState is OrderDetailsStateOwnerOrderLoaded &&
                    (currentState as OrderDetailsStateOwnerOrderLoaded)
                        .orderInfo
                        .orderIsMain,
                child: CustomC4dAppBar.actionIcon(context,
                    message: S.current.newOrderLink, onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return CustomAlertDialog(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed(
                                  OrdersRoutes.NEW_SUB_ORDER_SCREEN,
                                  arguments: orderId);
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
                        .isNotEmpty,
                child: CustomC4dAppBar.actionIcon(context,
                    message: S.current.unlinkSubOrders, onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return RemoveSubOrderDialog(
                          orders: (currentState
                                  as OrderDetailsStateOwnerOrderLoaded)
                              .orderInfo
                              .subOrders,
                          request: (request) {
                            manager.removeSubOrder(this, request);
                            Navigator.of(context).pop();
                          },
                        );
                      });
                }, icon: Icons.link_off),
              )
            ]),
        body: currentState.getUI(context),
      ),
    );
  }
}
