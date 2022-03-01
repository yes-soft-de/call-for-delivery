import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_subscription/state_manager/subscription_balance_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscriptionBalanceScreen extends StatefulWidget {
  final SubscriptionBalanceStateManager _stateManager;

  SubscriptionBalanceScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => SubscriptionBalanceScreenState();
}

class SubscriptionBalanceScreenState extends State<SubscriptionBalanceScreen> {
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
    widget._stateManager.getBalance(this);
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
