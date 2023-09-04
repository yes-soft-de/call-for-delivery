import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_plan/state_manager/captain_financial_dues_state_manager.dart';
import 'package:flutter/material.dart';

class CaptainFinancialDuesScreen extends StatefulWidget {
  const CaptainFinancialDuesScreen();

  @override
  State<StatefulWidget> createState() => CaptainFinancialDuesScreenState();
}

class CaptainFinancialDuesScreenState
    extends State<CaptainFinancialDuesScreen> {
  late States _currentState;
  late CaptainFinancialDuesStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  String? selectedPlan;
  @override
  void initState() {
    _currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    _stateManager.getAccountBalance(this);
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  CaptainFinancialDuesStateManager get manager => _stateManager;
  void refresh() {
    if (mounted) setState(() {});
  }

  void getAccount() {
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentState.getUI(context),
    );
  }
}
