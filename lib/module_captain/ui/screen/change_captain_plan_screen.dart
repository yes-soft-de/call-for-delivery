import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/state_manager/plan_screen_state_manager.dart';
import 'package:c4d/module_captain/ui/state/init_plan_state_loaded.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';

@injectable
class PlanScreen extends StatefulWidget {
  final PlanScreenStateManager _manager;

  const PlanScreen(this._manager);

  @override
  State<StatefulWidget> createState() => PlanScreenState();
}

class PlanScreenState extends State<PlanScreen> {
  States? _currentState;
  String? selectedPlan;
  @override
  void initState() {
    _currentState = InitCaptainPlanLoadedState(
      this,
      financeByHours: null,
      financeByOrder: null,
      financeByOrderCount: null,
    );
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  PlanScreenStateManager get manager => widget._manager;
  void refresh() {
    if (mounted) setState(() {});
  }

  void getAccount() {
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentState?.getUI(context) ?? Container(),
    );
  }
}
