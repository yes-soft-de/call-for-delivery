import 'dart:async';

import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/state_manager/plan_screen_state_manager.dart';
import 'package:c4d/module_captain/ui/state/init_plan_state_loaded.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen();

  @override
  State<StatefulWidget> createState() => PlanScreenState();
}

class PlanScreenState extends State<PlanScreen> {
  late States _currentState;
  late PlanScreenStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  String? selectedPlan;
  @override
  void initState() {
    _currentState = InitCaptainPlanLoadedState(
      this,
      financeByHours: null,
      financeByOrder: null,
      financeByOrderCount: null,
    );
    _stateManager = getIt();
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

  PlanScreenStateManager get manager => _stateManager;
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
