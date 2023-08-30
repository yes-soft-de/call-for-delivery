import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/navigator_assistant.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_orders/request/order/pending_order_request.dart';
import 'package:c4d/module_orders/state_manager/order_pending_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';

class OrderPendingScreen extends StatefulWidget {
  OrderPendingScreen();

  @override
  OrderPendingScreenState createState() => OrderPendingScreenState();
}

class OrderPendingScreenState extends State<OrderPendingScreen> {
  late States currentState;
  late OrderPendingStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  bool isExternalFilterOn = false;
  int currentIndex = 0;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void goToLogin() {
    Navigator.of(context)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN, arguments: 1);
  }

  var today = DateTime.now();
  @override
  void initState() {
    super.initState();
    currentIndex = NavigatorAssistant.nonDeliveringIndex;
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    getOrders();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  Future<void> getOrders([bool loading = true]) async {
    _stateManager.getPendingOrders(
      this,
      PendingOrderRequest(
        type: getPendingOrderRequest(),
      ),
      loading,
    );
  }

  PendingOrderRequestType getPendingOrderRequest() {
    if (isExternalFilterOn) return PendingOrderRequestType.onlyExternal;
    return PendingOrderRequestType.all;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
          appBar: CustomC4dAppBar.appBar(context,
              title: S.current.orders, icon: Icons.menu, onTap: () {
            GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
          }, actions: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    Text(
                      S.current.onlyExternal,
                    ),
                    SizedBox(width: 5),
                    Switch(
                      activeTrackColor: Color(0xff60CF86),
                      value: isExternalFilterOn,
                      onChanged: (value) {
                        isExternalFilterOn = value;
                        getOrders();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          ]),
          body: currentState.getUI(context)),
    );
  }
}
