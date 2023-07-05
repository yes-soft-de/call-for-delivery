import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_orders/request/payment/paymnet_status_request.dart';
import 'package:c4d/module_subscription/state_manager/new_subscription_balance_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class NewSubscriptionBalanceScreen extends StatefulWidget {
  final NewSubscriptionBalanceStateManager _stateManager;

  NewSubscriptionBalanceScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => NewSubscriptionBalanceScreenState();
}

class NewSubscriptionBalanceScreenState
    extends State<NewSubscriptionBalanceScreen> {
  late StreamSubscription _streamSubscription;
  late States currentState;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    _streamSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    getBalance();
    super.initState();
  }

  void getBalance() {
    widget._stateManager.getNewBalance(this);
  }

  void makePayment(PaymentStatusRequest request, {Function? onFinish}) {
    widget._stateManager.makePayment(request, onFinish: onFinish);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
