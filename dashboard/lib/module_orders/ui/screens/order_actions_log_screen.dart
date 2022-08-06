import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/state_manager/order_action_logs_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderActionLogsScreen extends StatefulWidget {
  final OrderActionLogsStateManager _stateManager;
  OrderActionLogsScreen(this._stateManager);

  @override
  OrderActionLogsScreenState createState() => OrderActionLogsScreenState();
}

class OrderActionLogsScreenState extends State<OrderActionLogsScreen> {
  int orderId = -1;
  late States currentState;
  StreamSubscription? firebaseStream;
  OrderActionLogsStateManager get manager => widget._stateManager;
  @override
  void initState() {
    currentState = LoadingState(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget._stateManager.stateStream.listen((event) {
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          currentState = event;
          if (mounted) {
            setState(() {});
          }
        });
      });
      firebaseStream =
          FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
        if (flag == false) {
          widget._stateManager.getActions(this, orderId, false);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    firebaseStream?.cancel();
    super.dispose();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && currentState is LoadingState && flag) {
      orderId = args as int;
      widget._stateManager.getActions(this, orderId);
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
            title: S.current.orderLogHistory + ' #$orderId',
            actions: [
              CustomC4dAppBar.actionIcon(context, onTap: () {
                widget._stateManager.getActions(this, orderId);
              }, icon: Icons.refresh),
            ]),
        body: currentState.getUI(context),
      ),
    );
  }
}
