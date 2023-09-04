import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/request/request_payment.dart';
import 'package:c4d/module_plan/state_manager/my_profits_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MyProfitsScreen extends StatefulWidget {
  const MyProfitsScreen();

  @override
  State<StatefulWidget> createState() => MyProfitsScreenState();
}

class MyProfitsScreenState extends State<MyProfitsScreen> {
  late States _currentState;
  late MyProfitsStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  @override
  void initState() {
    _currentState = LoadingState(this);
    _stateManager = getIt();
    getMyProfit();
    _stateSubscription = _stateManager.stateStream.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void getMyProfit() {
    _stateManager.getMyProfit(this);
  }

  void requestPayment() {
    _stateManager.requestPayment(this, RequestPayment(status: 1));
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.myProfits,
      ),
      body: _currentState.getUI(context),
    );
  }
}
