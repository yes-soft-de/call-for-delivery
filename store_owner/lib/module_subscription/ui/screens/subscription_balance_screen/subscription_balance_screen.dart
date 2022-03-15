import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_subscription/state_manager/subscription_balance_state_manager.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
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

  void renewSubscription(int id) {
    widget._stateManager.subscribePackage(this, id);
  }

  void extendSubscriptions() {
    widget._stateManager.extendPackage(this);
  }

  void subscribedToCaptainOffer(int id) {
    widget._stateManager.subscribeToCaptainOffer(this, id);
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
    widget._stateManager.getCaptainOffers(this);
    _globalStreamSubscription =
        getIt<GlobalStateManager>().stateStream.listen((event) {
      getBalance();
    });
    _captainsOffersStreamSubscription =
        widget._stateManager.captainOffersStream.listen((event) {
      snapshot = event;
      if (mounted) {
        setState(() {});
      }
    });
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
    _globalStreamSubscription.cancel();
    _captainsOffersStreamSubscription.cancel();
    super.dispose();
  }
}
