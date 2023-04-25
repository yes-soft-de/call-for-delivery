import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/navigator_assistant.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_orders/state_manager/order_pending_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';

@injectable
class OrderPendingScreen extends StatefulWidget {
  final OrderPendingStateManager _stateManager;

  OrderPendingScreen(this._stateManager);

  @override
  OrderPendingScreenState createState() => OrderPendingScreenState();
}

class OrderPendingScreenState extends State<OrderPendingScreen> {
  late States currentState;
  int currentIndex = 0;
  StreamSubscription? _stateSubscription;

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
    widget._stateManager.getPendingOrders(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

  Future<void> getOrders([bool loading = true]) async {
    widget._stateManager.getPendingOrders(this, loading);
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
          }),
          body: currentState.getUI(context)),
    );
  }
}
