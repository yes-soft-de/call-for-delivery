import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_subscription/state_manager/subscription_balance_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class NewSubscriptionBalanceScreen extends StatefulWidget {
  final SubscriptionBalanceStateManager _stateManager;

  NewSubscriptionBalanceScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => NewSubscriptionBalanceScreenState();
}

class NewSubscriptionBalanceScreenState
    extends State<NewSubscriptionBalanceScreen> {
  late StreamSubscription _streamSubscription;
  late StreamSubscription _globalStreamSubscription;
  late StreamSubscription _captainsOffersStreamSubscription;
  late States currentState;
  late AsyncSnapshot snapshot = const AsyncSnapshot.nothing();
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
    _globalStreamSubscription.cancel();
    _captainsOffersStreamSubscription.cancel();
    super.dispose();
  }
}
