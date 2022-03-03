import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status.state.dart';
import 'package:c4d/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../../../orders_routes.dart';

class OrderDetailsStateOwnerOrderLoaded extends OrderDetailsState {
  OrderModel currentOrder;

  OrderDetailsStateOwnerOrderLoaded(
    this.currentOrder,
    OrderStatusScreenState screenState,
  ) : super(screenState);
  bool redo = false;
  void showOwnerAlertConfirm(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(S.current.warnning),
            content: Container(
              child: Text('S.of(context).confirmingCaptainLocation'),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    //  showFlush(context, true);
                  },
                  child: Text('S.of(context).yes')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    //  showFlush(context, false);
                  },
                  child: Text('S.of(context).no'))
            ],
          );
        });
  }

  @override
  Widget getUI(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
        return false;
      },
      child: Scaffold(
          floatingActionButton: false
              ? FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text(S.of(context).confirm),
                            content: Container(
                              height: 50,
                              child: Text(S.of(context).sureForDelete),
                            ),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(S.of(context).cancel)),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    screenState.deleteOrder(currentOrder);
                                  },
                                  child: Text(S.of(context).confirm)),
                            ],
                          );
                        });
                  },
                  backgroundColor: Colors.red,
                  child: Icon(Icons.delete),
                )
              : null,
          body: Container()),
    );
  }
}
